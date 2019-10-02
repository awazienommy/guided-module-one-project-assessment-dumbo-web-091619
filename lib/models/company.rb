class Company < ActiveRecord::Base
  has_many :taxes
  has_many :purchases
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


  def taxes_payed
    self.taxes.map { |tax| tax.amount}.sum
  end


  def self.close_account(id)
    Company.destroy(id)
  end


  def self.get_all_industry_names
    Company.all.map { |company| company.industry }.uniq
  end


  def self.revenue_all_industries
    Company.get_all_industry_names.each do |name|
      Purchase.revenue_by_industry(name)
    end
  end


  def self.find_by_name(name_string)
    Company.all.filter { |company| company.name == name_string }
  end
end
