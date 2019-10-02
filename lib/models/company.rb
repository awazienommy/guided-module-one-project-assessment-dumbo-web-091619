class Company < ActiveRecord::Base
  has_many :taxes
  has_many :purchases
  has_many :customers, through: :purchases


  def change_product_price(new_price)
    # update product price
    self.product_price = new_price
  end


  def all_sales
    # get all sales for the company
    self.purchases
  end

  def sales_revenue
    # generate revenue for all sales for a company. need to add logic to not count sales that are refunded
    all_sales.map { |sale| sale.purchase_amount }.sum
  end


  def taxes_payed
    # total taxes payed for a company
    self.taxes.map { |tax| tax.amount}.sum
  end


  def self.close_account(id)
    # destroy company
    Company.destroy(id)
  end


  def self.get_all_industry_names
    # get a list of all industries in db
    Company.all.map { |company| company.industry }.uniq
  end


  def self.revenue_all_industries
    # this doesn't work
    Company.get_all_industry_names.each do |name|
      Purchase.revenue_by_industry(name)
    end
  end


  def self.find_by_name(name_string)
    # find a company by name
    Company.all.filter { |company| company.name == name_string }
  end
end
