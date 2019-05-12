json.data do
  json.extract! @user, :id, :name, :created_at, :updated_at
  json.last_week_sleeps @one_week_dates do |date|
    json.partial! 'api/v1/objects/sleep_by_date', sleep: @last_week_sleeps[date], date: date
  end
end
