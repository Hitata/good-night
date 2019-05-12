json.data do
  json.extract! @user, :id, :name, :created_at, :updated_at
  json.last_week_sleeps @last_week_sleeps do |sleep|
    json.id sleep.id
    json.date sleep.date
    json.clockin_at sleep.clockin_at
    json.clockout_at sleep.clockout_at
    json.sleep_time Time.at(sleep.clockout_at - sleep.clockin_at).utc.strftime('%H:%M:%S')
  end
end
