class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :product_price
      t.integer :government_id
      t.integer :company_id
      t.timestamps
  end
end
