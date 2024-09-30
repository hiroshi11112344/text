class User < ApplicationRecord
  has_many :quizzes, dependent: :destroy
end
