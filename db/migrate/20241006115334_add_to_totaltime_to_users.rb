class AddToTotaltimeToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :user_, :string
    add_column :users, :total_time, :float, from: nil, to: "0"
  end
end
