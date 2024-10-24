class User < ApplicationRecord
  has_many :quizzes, dependent: :destroy
  
  # Quiz_result中間テーブルの紐付け
  has_many :quiz_results
  has_many :quizzes, through: :quiz_results
end
