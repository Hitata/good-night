today = Date.current
user = User.find_by auth: '78eb7a778cd3e070d90d'
(2.weeks.ago(today)..today).each do |date|
  Sleep.seed(
    user_id: user.id,
    date: date,
    clockin_at: date.end_of_day - rand(0..4).hours,
    clockout_at: date.end_of_day + rand(0..8).hours
  )
end
