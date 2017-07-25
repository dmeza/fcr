class AddHistoryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :history, :text
  end
end
