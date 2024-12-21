class AddButtonToQuizzes < ActiveRecord::Migration[7.2]
  def change
    # AddButton_ToQuizzes
    add_column :quizzes, :select_button_value, :string
  end
end
