class Api::V1::UsersController < ApplicationController
  before_action :get_user, only: %i[show follows followers post_follows]
  def index
    @users =
      User
      .where.not(id: @current_user)
      .order(created_at: :desc)
  end

  def show
    @last_week_sleeps = @user.sleeps.group_by_and_from_date(1.week.ago.beginning_of_day)
  end

  def post_follows
    @follow = @current_user.follows.find_or_initialize_by(to_user: @user)
    error_message("Already followed user_id: #{@user.id}", :unprocessable_entity) unless @follow.new_record?
    @follow.save
  end

  def follows
    @follows = @user.follows
  end

  def followers
    @followers = @user.followers
  end

  private

  def get_user
    @user = User.find(params[:id])
  end
end
