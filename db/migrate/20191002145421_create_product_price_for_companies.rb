class CreateProductPriceForCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :product_price, :float, default: 10
  end
end
