class Quiz < ApplicationRecord
  has_one :answer, dependent: :destroy
  accepts_nested_attributes_for :answer

  belongs_to :user
  validates :question, presence: true
  validates :answer_1, presence: true
  validates :answer_2, presence: true
  validates :title, presence: true
  #validates :user_answer, presence: true quizテーブルのカラムではないのでエラーが起きます
  
end
