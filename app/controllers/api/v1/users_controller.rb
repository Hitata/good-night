class Api::V1::UsersController < ApplicationController
  before_action :get_user, only: %i[show follows followers post_follows last_week_order_sleep_time]
  def index
    @users =
      User
      .where.not(id: @current_user)
      .order(created_at: :desc)
  end

  def show
    today = Date.current
    one_week_ago = 1.week.ago(today)
    @one_week_dates = (one_week_ago..today).map(&:to_s)
    @last_week_sleeps = sleep_to_hash(@user.sleeps.from_date(one_week_ago))
  end

  def last_week_order_sleep_time
    @last_week_sleeps = @user.sleeps.from_date_order_by_sleep_time(1.week.ago)
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

  def sleep_to_hash(sleeps)
    sleeps.map { |sleep| [sleep.date.to_s, sleep] }.to_h
  end
end
