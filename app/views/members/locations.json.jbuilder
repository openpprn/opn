json.user_location @user_location

json.all_locations do
  json.array! @locations do |location|
    json.latitude location[:latitude]
    json.longitude location[:longitude]
  end
end

