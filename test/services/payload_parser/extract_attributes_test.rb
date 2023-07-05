require "test_helper"

module PayloadParser
  class ExtractAttributesTest < ActiveSupport::TestCase
    def setup
      payload = File.read(Rails.root.join('test', 'fixtures', 'files', 'payload_one.json'))
      @payload = JSON.parse(payload).with_indifferent_access

      @mapping = %w[name email phone].freeze
    end

    test 'runs successfully' do
      data = PayloadParser::ExtractAttributes.run(mapping: @mapping, payload: @payload)

      assert data.valid?
      assert_equal Hash, data.result.class
      assert data.result.keys.any? { |key| key.match(/email/) }, "No Key contains 'email'"
    end

    test 'errors with empty mapping' do
      result = PayloadParser::ExtractAttributes.run(mapping: [], payload: @payload)

      assert_not result.valid?
      assert_equal 'Mapping can\'t be blank', result.errors.full_messages.to_sentence
    end

    test 'errors with empty payload' do
      result = PayloadParser::ExtractAttributes.run(mapping: @mapping, payload: {})

      assert_not result.valid?
      assert_equal 'Payload can\'t be blank', result.errors.full_messages.to_sentence
    end
  end
end
