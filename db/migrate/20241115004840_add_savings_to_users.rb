class AddSavingsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :savings, :decimal
  end
end
