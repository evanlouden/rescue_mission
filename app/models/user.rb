class User < ActiveRecord::Base
  has_many :questions
  has_many :answers

  validates :username, presence: true 
end
