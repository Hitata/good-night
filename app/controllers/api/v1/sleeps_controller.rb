class Api::V1::SleepsController < ApplicationController
  before_action :get_sleep, only: %i[clockout]
  def clockin
    time = Time.current
    @sleep = @current_user.sleeps.find_or_initialize_by(date: time.to_date)
    error_message("Already clocked in at: #{@sleep.clockin_at}", :unprocessable_entity) unless @sleep.new_record?
    @sleep.update(clockin_at: time)
  end

  def clockout
    time = Time.current
    error_message("Already clocked out at: #{@sleep.clockout_at}", :unprocessable_entity) \
      if @sleep.clockout_at.present?
    @sleep.update(clockout_at: time)
  end

  private

  def get_sleep
    @sleep = Sleep.find(params[:id])
    error_message('Not allowed doing this operation', :unprocessable_entity) \
      if @sleep.user_id != @current_user.id
  end
end
