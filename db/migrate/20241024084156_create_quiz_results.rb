class CreateQuizResults < ActiveRecord::Migration[7.2]
  def change
    # QuizResult書くときはこっちの名前
    create_table :quiz_results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true
      t.integer :time_spent, default: 0 # デフォルト値を設定

      t.timestamps
    end
  end
end
