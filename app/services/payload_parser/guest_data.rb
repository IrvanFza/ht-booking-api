# frozen_literal_string: true

module PayloadParser
  # I use ActiveInteraction for easier service testing and validation
  # Read more: https://github.com/AaronLasseigne/active_interaction
  class GuestData < ActiveInteraction::Base
    hash :payload, strip: false

    validates :payload, presence: true

    # For simplicity of testing and deployment, we define the mapping in Rails credentials
    # This should be moved to envar or database so we don't need to update code when the mapping changes
    GUEST_MAPPING = Rails.application.credentials.guest_mapping&.split(',').freeze

    def execute
      return errors.add(:base, 'Guest mapping is empty') if GUEST_MAPPING.blank?

      compose(ExtractAttributes, mapping: GUEST_MAPPING, payload:)
    end
  end
end
