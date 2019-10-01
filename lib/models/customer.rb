class Customer < ActiveRecord::Base
    has_many :purchases
    has_many :companies, through: :purchases

  def get_purchases
    Purchase.all.filter { |purchase| purchase.customer_id == self.id }
  end


  def total_amount_spent
    get_purchases.map { |purchase| purchase.purchase_amount }.sum
  end


  def average_purchase
    total_amount_spent / get_purchases.size
  end


  
end
