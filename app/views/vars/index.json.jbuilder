json.array!(@vars) do |var|
  json.extract! var, :id, :name, :varNames, :boiler, :lastSetDate
  json.url var_url(var, format: :json)
end
