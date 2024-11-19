class MakeAddressNotNullInOrders < ActiveRecord::Migration[7.2]
  def change
    change_column :orders, :city, :string, null: false
    change_column :orders, :street, :string, null: false
    change_column :orders, :post_index, :string, null: false
    change_column :orders, :house_number, :string, null: false
    change_column :orders, :apartment_number, :string, null: false
  end
end
