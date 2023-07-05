class ApplicationController < ActionController::API
  before_action :authenticate

  # Simple authentication by checking if the request has the correct api key
  # In the real world application, we should use a more secure authentication method
  def authenticate
    api_key = request.headers['Api-Key']

    return if api_key == Rails.application.credentials.api_key

    render json: { status: 'error', message: 'Request is unauthorized' }, status: :unauthorized
  end
end
