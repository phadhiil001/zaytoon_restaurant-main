class AddCustomerDetailsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :name, :string
    add_column :orders, :email, :string
    add_column :orders, :address, :string
  end
end
