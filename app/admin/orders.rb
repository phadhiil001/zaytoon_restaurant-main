ActiveAdmin.register Order do
  permit_params :status, :total_price, :user_id, :province_id, :stripe_payment_id

  index do
    selectable_column
    id_column
    column :status
    column :total_price
    column :user
    column :province
    column :stripe_payment_id
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :status
      row :total_price
      row :user
      row :province
      row :stripe_payment_id
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :price
      end
    end

    panel "Order Tax" do
      attributes_table_for order.order_tax do
        row :gst
        row :pst
        row :hst
        row :qst
      end
    end
  end

  filter :status
  filter :total_price
  filter :user
  filter :province
  filter :stripe_payment_id
  filter :created_at
  filter :updated_at
end
