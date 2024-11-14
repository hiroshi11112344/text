class AddStartedatToQuizzes < ActiveRecord::Migration[7.2]
  def change
    add_column :quizzes, :started_at, :datetime unless column_exists?(:quizzes, :started_at)
    add_column :quizzes, :started_at, :datetime unless column_exists?(:quizzes, :started_at)
  end
end
