json.array!(@follows) do |follow|
  json.extract! follow, :id, :name
  json.url follow_url(follow, format: :json)
end
