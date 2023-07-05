require "test_helper"

module PayloadExtractor
  class ExtractPayloadTest < ActiveSupport::TestCase
    def setup
      payload = File.read(Rails.root.join('test', 'fixtures', 'files', 'payload_one.json'))
      @payload = JSON.parse(payload).with_indifferent_access

      @attributes = %w[name email phone].freeze
    end

    test 'runs successfully' do
      data = PayloadExtractor::ExtractPayload.run(attributes: @attributes, payload: @payload)

      assert data.valid?
      assert_equal Hash, data.result.class
      assert data.result.keys.any? { |key| key.match(/email/) }, "No Key contains 'email'"
    end

    test 'errors with empty attributes' do
      result = PayloadExtractor::ExtractPayload.run(attributes: [], payload: @payload)

      assert_not result.valid?
      assert_equal 'Attributes can\'t be blank', result.errors.full_messages.to_sentence
    end

    test 'errors with empty payload' do
      result = PayloadExtractor::ExtractPayload.run(attributes: @attributes, payload: {})

      assert_not result.valid?
      assert_equal 'Payload can\'t be blank', result.errors.full_messages.to_sentence
    end
  end
end
