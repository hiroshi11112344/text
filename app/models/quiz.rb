class Quiz < ApplicationRecord
  has_one :answer, dependent: :destroy
  accepts_nested_attributes_for :answer

  belongs_to :user
  validates :question, {presence: true, length:{maximum: 250}}
  validates :answer_1, {presence: true, length:{maximum: 50}}
  validates :answer_2, {presence: true, length:{maximum: 50}}
  validates :title, {presence: true, length:{maximum: 50}}
  
  # Quiz_result中間テーブルの紐付け
  has_many :quiz_results
  has_many :users, through: :quiz_results

  validates :select_button_value, presence: true

end
