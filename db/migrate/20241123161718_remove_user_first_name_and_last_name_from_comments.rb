class RemoveUserFirstNameAndLastNameFromComments < ActiveRecord::Migration[7.2]
  def change
    remove_column :comments, :user_first_name, :string
    remove_column :comments, :user_last_name, :string
  end
end
