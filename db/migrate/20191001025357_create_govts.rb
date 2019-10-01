class CreateGovts < ActiveRecord::Migration[5.2]
  def change
    create_table :govts do |t|
      t.string :name
      t.integer :account_number
    end
  end
end
