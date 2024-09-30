class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.references :quiz, null: false, foreign_key: true
      t.string :user_answer

      t.timestamps
    end
  end
end
