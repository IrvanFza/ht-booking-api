require "test_helper"

module PayloadExtractor
  class GuestDataTest < ActiveSupport::TestCase
    def setup
      @payload_two = JSON.parse(file_data('payload_two.json'))
      @payload_one = JSON.parse(file_data('payload_one.json'))
    end

    test 'runs successfully for payload one' do
      data = PayloadExtractor::GuestData.run(payload: @payload_one)

      assert data.valid?
      assert_equal Hash, data.result.class
      assert data.result.keys.any? { |key| key.match(/email/) }, "No Key contains 'email'"
    end

    test 'runs successfully for payload two' do
      data = PayloadExtractor::GuestData.run(payload: @payload_two)

      assert data.valid?
      assert_equal Hash, data.result.class
      assert data.result.keys.any? { |key| key.match(/email/) }, "No Key contains 'email'"
    end

    test 'errors with empty payload' do
      result = PayloadExtractor::GuestData.run(payload: {})

      assert_not result.valid?
      assert_equal 'Payload can\'t be blank', result.errors.full_messages.to_sentence
    end
  end
end
