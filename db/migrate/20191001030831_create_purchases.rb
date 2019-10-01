class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.integer :company_id
      t.integer :customer_id
      t.float :amount

    end
  end
end