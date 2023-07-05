# frozen_literal_string: true

module PayloadExtractor
  # I use ActiveInteraction for easier service testing and validation
  # Read more: https://github.com/AaronLasseigne/active_interaction
  class GuestData < ActiveInteraction::Base
    hash :payload, strip: false

    validates :payload, presence: true

    # For simplicity of testing and deployment, we define the mapping in Rails credentials
    # This should be moved to envar or database so we don't need to update code when the mapping changes
    GUEST_ATTRIBUTES = Rails.application.credentials.guest_attributes&.split(',').freeze

    def execute
      return errors.add(:base, 'Guest attributes is empty') if GUEST_ATTRIBUTES.blank?

      compose(ExtractPayload, attributes: GUEST_ATTRIBUTES, payload:)
    end
  end
end
