class CreateTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :taxes do |t|
      t.integer :government_id
      t.integer :company_id
      t.integer :amount
      t.boolean :refunded, default: false

      t.timestamps
    end
  end
end
