json.array!(@datalogs) do |datalog|
  json.extract! datalog, :id, :boiler_id, :values
  json.url datalog_url(datalog, format: :json)
end
