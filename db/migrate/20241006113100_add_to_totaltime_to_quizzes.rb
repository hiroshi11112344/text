class AddToTotaltimeToQuizzes < ActiveRecord::Migration[7.2]
  def change
    add_column :quizzes, :total_time, :float, from: nil, to: "0"
  end
end
