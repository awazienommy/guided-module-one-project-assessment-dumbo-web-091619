class CreateTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :taxes do |t|
      t.integer :government_id
      t.integer :customer_id
      t.integer :amount

      t.timestamps
    end
  end
end
