class LearningQuiz < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :learning_results
end
