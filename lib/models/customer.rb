class Customer < ActiveRecord::Base
    has_many :purchases
    has_many :companies, through: :purchases


  def new_purchase(company_instance, amount)
    # company_instance, customer_instance, purchase_amount
    Purchase.new_purchase(company_instance, self, amount)
    self.balance -= amount
    company_instance.balance += amount
    self.save
    company_instance.save
  end


  def make_return()
    purchase = self.purchases.sort_by { |purchase| purchase.id }.last
    if purchase.refunded == true
      "Sorry, this has already been refunded"
    else
      purchase.company.balance -= purchase.purchase_amount
      purchase.customer.balance += purchase.purchase_amount
      purchase.refunded = true
      purchase.save
      purchase.customer.save
      purchase.company.save
    end
  end


  def list_of_purchases
    self.purchases
  end


  def total_amount_spent
    list_of_purchases.map { |purchase| purchase.purchase_amount }.sum
  end


  def average_amount_spent
    total_amount_spent / list_of_purchases.size
  end


  def do_work
    self.balance += self.salary
    self.save
  end


  def self.close_account(id)
    Customer.destroy(id)
  end
end
