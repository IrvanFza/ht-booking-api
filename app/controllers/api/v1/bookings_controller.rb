# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      def create
        request_body = request.body.read

        return render json: { status: 'error', message: 'Payload cannot be empty' }, status: :bad_request if request_body.blank?

        payload = JSON.parse(request_body)
        booking = Bookings::Save.run(payload:)

        if booking.valid?
          render json: { status: 'success', data: booking.result }, status: :created
        else
          render json: { status: 'error', message: booking.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end
    end
  end
end
