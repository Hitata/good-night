class ApplicationController < ActionController::Base
  before_action :authenticate!, except: %i[auth]

  # For login with name
  def auth
  end

  # A simple authentication
  def authenticate!
    token = request.headers['Authorization'].try(:split, ' ').try(:last)
    @current_user = User.find_by auth: token
    error_message('Authorization token incorrect', :unauthorized) if @current_user.blank?
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    error_message(e.message, :not_found)
  end

  rescue_from(ActionController::ParameterMissing) do |e|
    error_message(e.message, :bad_request)
  end

  private

  def error_message(message, status = :unprocessable_entity)
    error = {message: message, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[status]}
    render json: {error: error}, status: status
  end
end
