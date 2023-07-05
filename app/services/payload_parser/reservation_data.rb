# frozen_literal_string: true

module PayloadParser
  # I use ActiveInteraction for easier service testing and validation
  # Read more: https://github.com/AaronLasseigne/active_interaction
  class ReservationData < ActiveInteraction::Base
    hash :payload, strip: false

    validates :payload, presence: true

    # For simplicity of testing and deployment, we define the mapping in Rails credentials
    # This should be moved to envar or database so we don't need to update code when the mapping changes
    RESERVATION_MAPPING = Rails.application.credentials.reservation_mapping&.split(',').freeze

    def execute
      return errors.add(:base, 'Reservation mapping is empty') if RESERVATION_MAPPING.blank?

      compose(ExtractAttributes, mapping: RESERVATION_MAPPING, payload:)
    end
  end
end
