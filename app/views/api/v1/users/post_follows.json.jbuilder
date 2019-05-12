json.data do
  json.id @follow.id
  json.to_user do
    json.id @follow.to_user.id
    json.name @follow.to_user.name
  end
end
