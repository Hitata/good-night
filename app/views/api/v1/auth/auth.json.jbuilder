json.data do
  json.extract! @current_user, :id, :name, :auth
end
