class CreateCompanys < ActiveRecord::Migration[5.2]
  def change
    create_table :companys do |t|
      t.integer :govt_id
      
      t.string :name
      t.float :balance
    end
  end
end
