class CreateFlowers < ActiveRecord::Migration[7.2]
  def change
    create_table :flowers do |t|
      t.string :imageUrl
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :stock

      t.timestamps
    end
  end
end
