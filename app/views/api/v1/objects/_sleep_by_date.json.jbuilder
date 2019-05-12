json.id sleep&.id
json.date sleep&.date || date
json.clockin_at sleep&.clockin_at
json.clockout_at sleep&.clockout_at
if sleep&.clockin_at.present? && sleep&.clockout_at.present?
  sleep_time = sleep.clockout_at - sleep.clockin_at
  json.sleep_time Time.at(sleep_time).utc.strftime('%H:%M:%S')
else
  json.sleep_time nil
end
