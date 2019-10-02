class CreateTaxRateForGovernments < ActiveRecord::Migration[5.2]
  def change
    add_column :governments, :tax_rate, :float, default: 0.0
  end
end
