class CreateTaxrecords < ActiveRecord::Migration[5.2]
  def change
    create_table :taxrecords do |t|
      t.string :government
      t.string :company
      t.datetime :tax_date
      t.float :tax_amount
    end
  end
end
