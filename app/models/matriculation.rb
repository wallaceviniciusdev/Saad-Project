class Matriculation < ActiveRecord::Base
  belongs_to :event
  validates :nome, :email, :telefone, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
