class Api::V1::BaseController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  before_action :authenticate

  private

  def authenticate
    authenticate_user_with_token || handle_bad_authentication
  end

  def authenticate_user_with_token
    authenticate_with_http_token do |token, options|
      ApiToken.where(active: true).find_by_token(token)
    end
  end

  def handle_bad_authentication
    render json: { message: "Bad credentials" }, status: :unauthorized
  end

  def handle_not_found
    render json: { message: "Record not found" }, status: :not_found
  end
end