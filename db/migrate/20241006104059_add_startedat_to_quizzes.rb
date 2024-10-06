class AddStartedatToQuizzes < ActiveRecord::Migration[7.2]
  def change
    add_column :quizzes, :started_at, :datetime
    add_column :quizzes, :started_at, :datetime
  end
end
