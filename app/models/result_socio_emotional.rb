class ResultSocioEmotional < ActiveRecord::Base
  belongs_to :user
  belongs_to :question_socio_emotional
end