class Answer < ApplicationRecord
  belongs_to :quiz
  #belongs_to :user, optional: true  # user_id が nil でも許容される
end
