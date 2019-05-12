json.data @users do |user|
  json.id user.id
  json.name user.name
  json.followed_by_me_id user.follow_id
end
