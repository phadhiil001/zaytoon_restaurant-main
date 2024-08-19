class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.references :category, null: false, foreign_key: true
      t.text :options
      t.string :served_with
      t.integer :pieces
      t.text :extra

      t.timestamps
    end
  end
end
