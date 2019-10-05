class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.float :balance, default: 0.00
      t.string :industry
      t.integer :account_num
      t.string :location
      
    end
  end
end
