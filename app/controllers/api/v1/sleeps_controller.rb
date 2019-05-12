class Api::V1::SleepsController < ApplicationController
  def clockin
    time = Time.current
    @sleep = @current_user.sleeps.find_or_initialize_by(date: time.to_date)
    error_message("Already clocked in at: #{@sleep.clockin_at}", :unprocessable_entity) unless @sleep.new_record?
    @sleep.update(clockin_at: time)
  end

  def clockout
    time = Time.current
    @sleep = @current_user.sleeps.find_by date: time.to_date
    error_message("Already clocked out at: #{@sleep.clockout_at}", :unprocessable_entity) \
      if @sleep.present? && @sleep.clockout_at.present?
    @sleep.update(clockout_at: time)
  end
end
