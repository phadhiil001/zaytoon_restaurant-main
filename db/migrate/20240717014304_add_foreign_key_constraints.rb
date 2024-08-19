class AddForeignKeyConstraints < ActiveRecord::Migration[7.1]
  def change
    # Adding foreign key constraints with on_delete: :cascade for orders table
    if foreign_key_exists?(:orders, :users)
      remove_foreign_key :orders, :users
    end
    add_foreign_key :orders, :users, on_delete: :cascade

    # Adding foreign key constraints with on_delete: :cascade for order_items table
    if foreign_key_exists?(:order_items, :orders)
      remove_foreign_key :order_items, :orders
    end
    add_foreign_key :order_items, :orders, on_delete: :cascade

    # Adding foreign key constraints with on_delete: :cascade for order_taxes table
    if foreign_key_exists?(:order_taxes, :orders)
      remove_foreign_key :order_taxes, :orders
    end
    add_foreign_key :order_taxes, :orders, on_delete: :cascade
  end
end
