class Company < ActiveRecord::Base
  has_many :taxes
  has_many :purchases
  # has_many :companies, through: :taxes
  has_many :customers, through: :purchases


  def change_product_price(new_price)
    self.product_price = new_price
  end


  def all_sales
    self.purchases
  end

  def sales_revenue
    all_sales.map { |sale| sale.purchase_amount }.sum
  end

end
