class Api::V1::UsersController < ApplicationController
  def index
    @users =
      User
      .where.not(id: @current_user)
      .order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end
end
