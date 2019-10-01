class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.float :balance
      t.integer :account_num
      t.float :salary
    end
  end
end
