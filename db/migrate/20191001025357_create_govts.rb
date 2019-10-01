class CreateGovts < ActiveRecord::Migration[5.2]
  def change
    create_table :govts do |t|
      t.string :name
      t.float :balance
      t.integer :account_num
    end
  end
end
