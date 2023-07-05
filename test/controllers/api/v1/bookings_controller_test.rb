require 'test_helper'

module Api
  module V1
    class BookingsControllerTest < ActionDispatch::IntegrationTest
      def setup
        @payload_two = JSON.parse(file_data('payload_two.json'))
        @payload_one = JSON.parse(file_data('payload_one.json'))
      end

      test 'it should successfully create booking' do
        post api_v1_bookings_url, params: @payload_one, as: :json

        assert_response :created
      end

      test 'it should successfully create booking with different payload' do
        post api_v1_bookings_url, params: @payload_two, as: :json

        assert_response :created
      end

      test 'it should return error when payload is empty' do
        post api_v1_bookings_url, as: :json, params: nil

        assert_response :bad_request
        assert_equal({ 'status' => 'error', 'message' => 'Payload cannot be empty' }, response.parsed_body)
      end

      test 'it should return error when payload is invalid' do
        @payload_one['guest']['email'] = nil

        post api_v1_bookings_url, params: @payload_one, as: :json

        assert_response :unprocessable_entity
        assert_equal({ 'status' => 'error', 'message' => 'Email can\'t be blank' }, response.parsed_body)
      end
    end
  end
end