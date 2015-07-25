json.array!(@mappings) do |mapping|
  json.extract! mapping, :id, :path, :uri, :datatype
  json.url mapping_url(mapping, format: :json)
end
