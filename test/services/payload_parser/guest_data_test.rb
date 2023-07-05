require "test_helper"

module PayloadParser
  class GuestDataTest < ActiveSupport::TestCase
    def setup
      @payload_one = payload_one
      @payload_two = payload_two
    end

    test 'runs successfully for payload one' do
      data = PayloadParser::GuestData.run(payload: @payload_one)

      assert_equal Hash, data.result.class
      assert data.result.keys.any? { |key| key.match(/email/) }, "No Key contains 'email'"
    end

    test 'runs successfully for payload two' do
      data = PayloadParser::GuestData.run(payload: @payload_two)

      assert_equal Hash, data.result.class
      assert data.result.keys.any? { |key| key.match(/email/) }, "No Key contains 'email'"
    end

    test 'errors with empty payload' do
      result = PayloadParser::GuestData.run(payload: {})

      assert_not result.valid?
      assert_equal 'Payload can\'t be blank', result.errors.full_messages.to_sentence
    end
  end
end
