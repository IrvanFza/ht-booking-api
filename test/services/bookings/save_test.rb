require "test_helper"

module Bookings
  class SaveTest < ActiveSupport::TestCase
    def setup
      @payload_two = JSON.parse(file_data('payload_two.json'))
      @payload_one = JSON.parse(file_data('payload_one.json'))
    end

    test 'it should fail when payload is missing' do
      booking = Bookings::Save.run(payload: nil)
      assert_not booking.valid?
      assert_equal booking.errors.full_messages.to_sentence, 'Payload is required'
    end

    test 'it should fail when guest data is invalid' do
      @payload_one['guest']['email'] = nil
      booking = Bookings::Save.run(payload: @payload_one)
      assert_not booking.valid?
      assert_equal booking.errors.full_messages.to_sentence, 'Email can\'t be blank'
    end

    test 'it should fail when reservation data is invalid' do
      @payload_one['reservation_code'] = nil
      booking = Bookings::Save.run(payload: @payload_one)
      assert_not booking.valid?
      assert_equal booking.errors.full_messages.to_sentence, 'Code can\'t be blank'
    end

    test 'it should successfully save when parameters are valid' do
      booking = Bookings::Save.run(payload: @payload_one)
      assert booking.valid?
    end

    test 'it should successfully save when using different payload' do
      booking = Bookings::Save.run(payload: @payload_two)
      assert booking.valid?
    end
  end
end
