class ApiBaseController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  private

  def authenticate
    authenticate_user_from_token || render_unauthorized
  end

  def authenticate_user_from_token
    authenticate_with_http_token do |token, _options|
      @user ||= User.find_by(token: token)
    end
  end

  def render_unauthorized
    render json: { message: "Invalid token." }, status: :unauthorized
  end

  def render_parameter_missing(exception)
    render json: { message: exception.message }, status: :unprocessable_entity
  end
end