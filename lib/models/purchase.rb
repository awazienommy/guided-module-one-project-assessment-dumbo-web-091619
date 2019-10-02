class Purchase < ActiveRecord::Base
  belongs_to :customer
  belongs_to :company

  def self.new_purchase(company_instance, customer_instance, purchase_amount)
    Purchase.create(company_id: company_instance.id, customer_id: customer_instance.id, purchase_amount: purchase_amount)
  end


  def self.get_refund(purchase_instance)
    purchase_instance.company.balance -= purchase_instance.purchase_amount
    purchase_instance.customer.balance += purchase_instance.purchase_amount
    purchase_instance.refunded = true
    purchase_instance.company.save
    purchase_instance.customer.save
    purchase_instance.save
    purchase_instance.update(company.balance,)
  end


  def self.revenue_by_industry(industry_string)
    filtered = Purchase.all.filter { |purchase| purchase.company.industry == industry_string }
    filtered.map { |purchase| purchase.company.sales_revenue }.first
  end
end
