json.data do
  json.array! @follows do |follow|
    json.id follow.id
    json.to_user do
      json.id follow.to_user.id
      json.name follow.to_user.name
    end
  end
end
