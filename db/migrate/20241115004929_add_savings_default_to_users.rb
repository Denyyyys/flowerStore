class AddSavingsDefaultToUsers < ActiveRecord::Migration[7.2]
  def change
    change_column :users, :savings, :decimal, precision: 15, scale: 2, default: 0.0
  end
end
