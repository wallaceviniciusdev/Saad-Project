json.array!(@campus) do |campu|
  json.extract! campu, :id, :name, :institution_id
  json.url campu_url(campu, format: :json)
end
