class Api::V1::UsersController < ApplicationController
  def index
    @data = User.all
  end

  def show
    @data = User.find(params[:id])
  end
end