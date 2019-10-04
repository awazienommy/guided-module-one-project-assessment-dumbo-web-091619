class Customer < ActiveRecord::Base
    has_many :purchases
    has_many :companies, through: :purchases
    @@prompt = TTY::Prompt.new



    
  def self.new_purchase
    customer_input = @@prompt.ask("What is your name?")
    customer = Customer.find_by(name: customer_input)
    company_input = @@prompt.ask("What company are you buying from?")
    company = Company.find_by(name: company_input)
    price = @@prompt.ask("What is the price of the item?").to_f
    new_company_balance = company.balance + price
    new_customer_balance = customer.balance - price
    new_purchase = Purchase.create(company_id: company.id, customer_id: customer.id, purchase_amount: price, refunded: false)
    company.update(balance: new_company_balance)
    customer.update(balance: new_customer_balance)
    puts "Thanks for making a purchase of $#{price} from #{company.name} today."
    # binding.pry
    Interface.customer_main_menu
  end


  def self.make_return
    customer_name_input= @@prompt.ask("What is your name?")
    customer = Customer.find_by(name: customer_name_input)
    customer_amount_input = @@prompt.ask("What what is the purchase amount?").to_f
    purchase = Purchase.find_by(purchase_amount: customer_amount_input)
    if purchase.customer_id = customer.id
      purchase.update(refunded: true)
      new_customer_balance = customer.balance + customer_amount_input
      customer.update(balance: new_customer_balance)
    else
      puts "Purchase not found"
    end
    Interface.customer_main_menu
  end


#   def list_of_purchases
#     # get a list of all purchases for an instance using ActiveRecord magic
#     self.purchases
#   end


#   def total_amount_spent
#     calculates the total amount spent on all purchases
#     list_of_purchases.map { |purchase| purchase.purchase_amount }.sum
#   end


#   def average_amount_spent
#     determines the average amount spent on all purchases
#     total_amount_spent / list_of_purchases.size
#   end


#   def do_work
#     # does work to increase balance and updates database
#     self.balance += self.salary
#     self.save
#   end


#   def self.close_account(id)
#     # destroys customer instance and db info
#     Customer.destroy(id)
#   end
# end
