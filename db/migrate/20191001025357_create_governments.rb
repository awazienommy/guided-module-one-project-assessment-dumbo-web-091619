class CreateGovernments < ActiveRecord::Migration[5.2]
  def change
    create_table :governments do |t|
      t.string :name
      t.float :balance, default: 0.00
      t.integer :account_num
      t.float :tax_rate, default: 0.00
      t.timestamps
    end
  end
end

#added the timestamp colums to enable us track updates of tax rates