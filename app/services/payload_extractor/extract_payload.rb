# frozen_literal_string: true

module PayloadExtractor
  # I use ActiveInteraction for easier service testing and validation
  # Read more: https://github.com/AaronLasseigne/active_interaction
  class ExtractPayload < ActiveInteraction::Base
    array :attributes
    hash :payload, strip: false

    validates :attributes, :payload, presence: true

    def execute
      extract_attributes(payload, attributes)
    end

    private

    # Extract the payload and return only the attributes that are defined in the attributes
    # @param [Hash] data
    # @param [Array] attributes
    def extract_attributes(data, attributes)
      result = {}
      data.each do |key, value|
        key = key.to_s.downcase
        attr_name = attributes.find { |map| key.include?(map) }
        if value.is_a?(Hash)
          # Recursively parse nested attributes and merge them into the result
          result.merge!(extract_attributes(value, attributes))
        else
          result[key] = value if attr_name
        end
      end
      result
    end
  end
end
