class User < ApplicationRecord
  has_many :quizzes, dependent: :destroy

  # メールアドレスのバリデーション
  # 空白を許可しない、同じメールアドレスを許可しない　メールアドレスの形式をチェック
  validates :email, presence: true, uniqueness: true,  format: { with: URI::MailTo::EMAIL_REGEXP }
    
  # Quiz_result中間テーブルの紐付け
  has_many :quiz_results
  has_many :quizzes, through: :quiz_results
end
