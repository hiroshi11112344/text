class Answer < ApplicationRecord
  belongs_to :quiz
  #belongs_to :user, optional: true  # user_id が nil でも許容される

  validates :user_answer, {presence: true, length:{maximum: 50}}
end
