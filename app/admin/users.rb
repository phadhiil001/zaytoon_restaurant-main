ActiveAdmin.register User do

  permit_params :email, :password, :password_confirmation, :province_id, :name, :address, :stripe_payment_id

  controller do
    def destroy
      @user = User.find(params[:id])
      if @user.destroy
        redirect_to admin_users_path, notice: "User and associated orders were successfully deleted."
      else
        redirect_to admin_users_path, alert: "Unable to delete user."
      end
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :province
    column :address
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :email
  filter :province
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :province
      f.input :address
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :name
      row :address
      row :province
      row :created_at
      row :updated_at
    end

    panel "Orders" do
      table_for user.orders do
        column :id
        column :status
        column :total_price
        column :stripe_payment_id
        column :created_at
        column :updated_at
      end
    end
  end

  class AddDeviseToUsers < ActiveRecord::Migration[6.0]
    def change
      change_table :users do |t|
        t.string :encrypted_password, null: false, default: ""
        t.string :reset_password_token
        t.datetime :reset_password_sent_at
        t.datetime :remember_created_at
        t.string :confirmation_token
        t.datetime :confirmed_at
        t.datetime :confirmation_sent_at
        t.string :unconfirmed_email
        t.integer :failed_attempts, default: 0, null: false
        t.string :unlock_token
        t.datetime :locked_at

        t.string :name
        t.text :address
        t.references :province, foreign_key: true
      end

      add_index :users, :email, unique: true
      add_index :users, :reset_password_token, unique: true
      add_index :users, :confirmation_token, unique: true
      add_index :users, :unlock_token, unique: true
    end
  end



end
