json.data do
  json.array! @followers do |follower|
    json.id follower.id
    json.from_user do
      json.id follower.from_user.id
      json.name follower.from_user.name
    end
  end
end
