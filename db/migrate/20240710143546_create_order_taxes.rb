class CreateOrderTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :order_taxes do |t|
      t.decimal :gst
      t.decimal :pst
      t.decimal :hst
      t.decimal :qst
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
