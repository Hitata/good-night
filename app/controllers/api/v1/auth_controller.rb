class Api::V1::AuthController < ApplicationController
  def auth
    # TODO: authentication validation here normally with name, password
    @current_user = User.find_by name: auth_params
    error_message("User with name: '#{auth_params}' doesn't exist", :unauthorized) if @current_user.blank?
  end

  def auth_params
    params.require(:name)
  end
end
