class Customer < ActiveRecord::Base
    has_many :purchases
    has_many :companies, through: :purchases


  def new_purchase(company_instance, amount)
    # company_instance, customer_instance, purchase_amount
    # Creates a new purchase and updates balance of company and customer
    Purchase.new_purchase(company_instance, self, amount)
    self.balance -= amount
    company_instance.balance += amount
    self.save
    company_instance.save
  end


  def make_return()
    # Makes a return if not already returned and updates balance of customer and company. Also throws returned flag on purchase to true. If flag is true you can't return as it's already returned.
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
    # get a list of all purchases for an instance using ActiveRecord magic
    self.purchases
  end


  def total_amount_spent
    calculates the total amount spent on all purchases
    list_of_purchases.map { |purchase| purchase.purchase_amount }.sum
  end


  def average_amount_spent
    determines the average amount spent on all purchases
    total_amount_spent / list_of_purchases.size
  end


  def do_work
    # does work to increase balance and updates database
    self.balance += self.salary
    self.save
  end


  def self.close_account(id)
    # destroys customer instance and db info
    Customer.destroy(id)
  end
end
