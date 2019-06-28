class QuestionSocioEmotional < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :result_socio_emotionals
end
