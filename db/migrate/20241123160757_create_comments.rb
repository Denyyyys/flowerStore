class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.string :user_first_name
      t.string :user_last_name
      t.text :body
      t.references :flower, null: false, foreign_key: true

      t.timestamps
    end
  end
end
