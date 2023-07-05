# frozen_literal_string: true

module PayloadParser
  # I use ActiveInteraction for easier service testing and validation
  # Read more: https://github.com/AaronLasseigne/active_interaction
  class ExtractAttributes < ActiveInteraction::Base
    array :mapping
    hash :payload, strip: false

    validates :mapping, :payload, presence: true

    def execute
      extract_attributes(payload, mapping)
    end

    private

    # Extract the payload and return only the attributes that are defined in the mapping
    # @param [Hash] data
    # @param [Array] mapping
    def extract_attributes(data, mapping)
      result = {}
      data.each do |key, value|
        key = key.to_s.downcase
        attr_name = mapping.find { |map| key.include?(map) }
        if value.is_a?(Hash)
          # Recursively parse nested attributes and merge them into the result
          result.merge!(extract_attributes(value, mapping))
        else
          result[key] = value if attr_name
        end
      end
      result
    end
  end
end
