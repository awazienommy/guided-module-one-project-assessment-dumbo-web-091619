class Customer < ActiveRecord::Base
    has_many :purchases
    has_many :companies, through: :purchases
    @@prompt = TTY::Prompt.new
    
  def self.new_purchase
    #purchasing customer details
    customer_input = @@prompt.ask("What is your name?")
    customer = Customer.find_by(name: customer_input)
    #details of company to be bought from
    company_input = @@prompt.ask("What company are you buying from?")
    company = Company.find_by(name: company_input)
    #product being bought
    company_products = Company.all.map {|product| product.name}
    product = @@prompt.select("Select the product you want", company_products, per_page: 10)
    #calculations
    new_company_balance = company.balance + product.product_price
    new_customer_balance = customer.balance - product.product_price
    #create purchase instance and save to database
    new_purchase = Purchase.create(company_id: company.id, customer_id: customer.id, product_name: product.name, purchase_amount: product.product_price, refunded: false)
    #update customer and company balances to reflect purchase action
    company.update(balance: new_company_balance)
    customer.update(balance: new_customer_balance)
    system "clear"
    puts "--------------------"
    puts "Thanks for making a purchase of $#{price} from #{company.name} today."
    Interface.customer_main_menu
  end


  def self.make_return
    #customer making return
    customer_name_input= @@prompt.ask("What is your name?")
    customer_instance = Customer.find_by(name: customer_name_input)
    #purchase being returned
    customer_purchases = customer_instance.purchases
    purchase_names = customer_purchases.map {|purchase| purchase.name}
    name_of_purchase_to_be_returned = @@prompt.select("Select the purchase you want to return", purchase_names, per_page: 10)
    purchase_to_be_returned_instance = customer_purchases.find_by(name: name_of_purchase_to_be_returned)
    #company purchase was made from
    company_purchase_was_made_from = Company.find_by(id: purchase_to_be_returned_instance.company_id)
    #next line checks if purchase is not already refunded, else refund it
    if purchase_to_be_returned_instance.return == false
      purchase_to_be_returned_instance.update(refunded: true)
      #calculaitions
      new_customer_balance = customer_instance.balance + purchase_to_be_returned_instance.amount
      new_company_balance = purchase_to_be_returned_instance.amount + company_purchase_was_made_from.balance
      customer_instance.update(balance: new_customer_balance)
      company_purchase_was_made_from.update(balance: new_company_balance)
      system "clear"
      puts "----------------------------"
      puts "Your refund for $#{selected_purchase_instance.amount} has been processed. This should reflect on your balance"
    else
      system "clear"
      puts "----------------------------"
      puts "Purchase not found"
    end
    Interface.customer_main_menu
  end

end


  def list_of_purchases
    system "clear"
    puts "----------------------------"
    puts "Your purchases are as listed below"
    purchases.each_with_index {|purchase, index| puts "Purchase No#{index + 1}", "Item name: #{purchase.product_name}", "Purchase amount: $#{purchase.purchase_amount} "}
  end


  def total_amount_spent #calculates the total amount spent on all purchases
     total = purchases.map { |purchase| purchase.purchase_amount }.sum
     puts "Date: #{Time.now}", "Total Amount Spent: #{total}"
  end


  def average_amount_spent #determines the average amount spent on all purchases
    purchases.map { |purchase| purchase.purchase_amount }.sum / purchases.length
  end


  def do_work #does work to increase balance and updates database
    salary = 1000
    new_balance = self.balance + salary
    self.update(balance: new_balance)
    puts "Congrats, you've been paid", "Payment date: #{Time.now}" "Payment amo"
  end


  def close_account # destroys customer instance and db info
    if @@prompt.yes?("Do you want to delete your accont and all your records?")
        purchases.all.each {|purchase| purchase.delete }
        self.delete
        system "clear"
        puts "----------------------------"
        puts "Sorry to see you leave. Hopefully you can come back to the tax interchange later"
    elsif @@prompt.yes?("Do you want to delete just the country account and leave your records?")
        self.delete
        system "clear"
        puts "----------------------------"
        puts "Sorry to see you leave. Hopefully you can come back to the tax interchange later"
    end
        Interface.welcome #Send them back to welcome page
    end
  end
end
