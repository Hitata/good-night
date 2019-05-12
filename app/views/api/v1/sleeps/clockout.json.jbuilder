json.data do
  json.extract! @sleep, :id, :date, :clockin_at, :clockout_at, :created_at, :updated_at
end
