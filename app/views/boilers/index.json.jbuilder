json.array!(@boilers) do |boiler|
  json.extract! boiler, :id
  json.url boiler_url(boiler, format: :json)
end
