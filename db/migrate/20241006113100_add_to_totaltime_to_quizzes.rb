class AddToTotaltimeToQuizzes < ActiveRecord::Migration[7.2]
  def change
    #add_column :quizzes, :total_time, :float, from: nil, to: "0"
    #↓に書き換え　１１/14
    add_column :quizzes, :total_time, :float, default: 0

  end
end
