class CreateCompanys < ActiveRecord::Migration[5.2]
  def change
    create_table :companys do |t|      
      t.string :name
      t.float :balance
      t.string :industry
      t.integer :account_num
      t.string :location
    end
  end
end
