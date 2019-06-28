json.array!(@question_socio_emotionals) do |question_socio_emotional|
  json.extract! question_socio_emotional, :id, :user_id, :data_final
  json.url question_socio_emotional_url(question_socio_emotional, format: :json)
end
