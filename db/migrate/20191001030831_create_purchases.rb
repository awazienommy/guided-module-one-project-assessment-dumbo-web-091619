class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.integer :company_id
      t.integer :customer_id
      t.datetime :purchase_date
      t.float :purchase_amount

    end
  end
end
