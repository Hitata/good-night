class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do |e|
    error_message(e.message, :not_found)
  end

  private

  def error_message(message, status = :unprocessable_entity)
    error = {message: message, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[status]}
    render json: {error: error}, status: status
  end
end
