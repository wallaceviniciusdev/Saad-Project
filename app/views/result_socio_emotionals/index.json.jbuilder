json.array!(@result_socio_emotionals) do |result_socio_emotional|
  json.extract! result_socio_emotional, :id, :data_final, :cons_emoc, :reg_emoc, :cons_soc, :aut_emoc, :cria_emoc, :student_id, :question_socio_emotional_id
  json.url result_socio_emotional_url(result_socio_emotional, format: :json)
end





