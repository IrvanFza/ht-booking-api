# frozen_literal_string: true

module PayloadExtractor
  # I use ActiveInteraction for easier service testing and validation
  # Read more: https://github.com/AaronLasseigne/active_interaction
  class ReservationData < ActiveInteraction::Base
    hash :payload, strip: false

    validates :payload, presence: true

    # For simplicity of testing and deployment, we define the mapping in Rails credentials
    # This should be moved to envar or database so we don't need to update code when the mapping changes
    RESERVATION_ATTRIBUTES = Rails.application.credentials.reservation_attributes&.split(',').freeze

    def execute
      return errors.add(:base, 'Reservation attributes is empty') if RESERVATION_ATTRIBUTES.blank?

      compose(ExtractPayload, attributes: RESERVATION_ATTRIBUTES, payload:)
    end
  end
end
