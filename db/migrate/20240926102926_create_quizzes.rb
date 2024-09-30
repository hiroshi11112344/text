class CreateQuizzes < ActiveRecord::Migration[7.2]
  def change
    create_table :quizzes do |t|
      t.string :question
      t.string :answer_1
      t.string :answer_2

      t.timestamps
    end
  end
end
