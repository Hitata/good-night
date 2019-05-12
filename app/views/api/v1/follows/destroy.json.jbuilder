json.data do
  json.extract! @current_user, :id, :name
  json.message 'Unfollowed succesful'
end
