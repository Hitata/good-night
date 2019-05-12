json.data @last_week_sleeps do |sleep|
  json.id sleep&.id
  json.date sleep&.date
  json.clockin_at sleep&.clockin_at
  json.clockout_at sleep&.clockout_at
  json.sleep_time sleep&.sleep_time
end
