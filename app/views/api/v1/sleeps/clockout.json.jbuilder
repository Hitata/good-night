json.data do
  json.extract! @sleep, :date, :clockin_at, :clockout_at, :created_at, :updated_at
end
