class AddUserIdTo < ActiveRecord::Migration[7.2]
  def change
    add_reference :quizzes, :user, null: false, foreign_key: true
  end
end
#foreign_key: true は、Userテーブルのidを参照する外部キー制約を追加します。
#もし、user_id を必須したい場合は、null: false （逆もまた然り）とすることができます。