class AddAddressToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :city, :string
    add_column :orders, :street, :string
    add_column :orders, :post_index, :string
    add_column :orders, :house_number, :string
    add_column :orders, :apartment_number, :string
  end
end
