# frozen_string_literal: true

module Bookings
  class Save < ActiveInteraction::Base
    hash :payload, strip: false

    validates :payload, presence: true

    def execute
      # Extract guest data from the payload
      guest_data = PayloadExtractor::GuestData.run(payload:)
      return errors.add(:base, guest_data.errors.full_messages.to_sentence) unless guest_data.valid?

      # Extract reservation data from the payload
      reservation_data = PayloadExtractor::ReservationData.run(payload:)
      return errors.add(:base, reservation_data.errors.full_messages.to_sentence) unless reservation_data.valid?

      # Since the extracted data keys are different from the database column names,
      # we need to map the data key to match the database column names
      mapped_guest_data = map_payload_key_to_column_name(guest_data.result, Guest.column_names)
      mapped_reservation_data = map_payload_key_to_column_name(reservation_data.result, Reservation.column_names)

      # Because we need to save both guest and reservation data,
      # we need to wrap it in a transaction to make sure both data are saved
      ActiveRecord::Base.transaction do
        # Save guest record
        guest = Guest.find_or_initialize_by(email: mapped_guest_data['email'])
        guest.assign_attributes(mapped_guest_data)

        return errors.add(:base, guest.errors.full_messages.to_sentence) unless guest.save

        # Save reservation record
        reservation = Reservation.find_or_initialize_by(code: mapped_reservation_data['code'])
        reservation.assign_attributes(mapped_reservation_data)
        reservation.guest = guest

        return errors.add(:base, reservation.errors.full_messages.to_sentence) unless reservation.save

        reservation.as_json(include: :guest)
      end
    end

    private

    def map_payload_key_to_column_name(payload, column_names)
      result = {}
      payload.each do |key, value|
        column_name = column_names.find do |column|
          # Skip column name that contains 'id'
          next if column.include?('id') || price_attribute?(key)

          # Only match the first word of the column name
          name = column.split('_')&.first
          key.include?(name)
        end

        column_name = price_key_to_column_name(key) if price_attribute?(key)

        # Skip if the key is not found in the column names
        # To make sure no errors are raised when saving missing attributes
        next unless column_name

        result[column_name] = value.is_a?(Array) ? value.first : value
      end

      result
    end

    def price_key_to_column_name(key)
      return 'total_price' if key.include?('total')
      return 'additional_price' if key.include?('security')

      'sub_total_price'
    end

    def price_attribute?(key)
      key.include?('price') || key.include?('amount')
    end
  end
end
