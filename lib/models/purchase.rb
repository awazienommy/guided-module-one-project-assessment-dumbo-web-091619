class Purchase < ActiveRecord::Base
  belongs_to :customer
  belongs_to :company

  def self.new_purchase
    #this should be steped into from customer
    company_input = @@prompt.ask("What is the company you are buying from?")
    company = Company.find_by(name: company_input)
    products_names = Company.products.map {|product| product.name}
    product_input = @@prompt.select("What is the product you want to buy?", products_names, per_page: 10)
    product_instance = Product.find_by(name: product_input)
    quantity = @@prompt.ask("What is the quantity you want to purchase?").to_i
    purchase_amount = product_instance.price * quantity
    Purchase.create(company_id: company.id, customer_id: customer.id, product_name: product_instance.name, purchase_amount: purchase_amount, refunded: false)
    puts "-----Purchase-----" "Product: #{product_instance.name}" "Quantity: #{quantity}" "Company: #{company.name}" "Amount: #{purchase_amount}"
    Interface.customer_main_menu
  end


  # def self.get_refund
  #   customer_name_input = @@prompt.ask("Welcome to refunds. What is your name?")
  #   customer_instance = Customer.find_by(name: customer_name_input)
  #   purchases = Purchase.select(customer_instance: customer_instance.id)
  #   purchases_names = purchases.map {|purchase| purchase.name}
  #   selected_purchase_name = @@prompt.select("What which purchase do you want a refund for?", purchases_names, per_page: 10)
  #   selected_purchase_instance = purchases.find_by(name: selected_purchase_name)
  #   if selected_purchase_instance_company_instance.refund
  #     puts "Sorry, but you have already got a refund for this purchase"
  #   else
  #     selected_purchase_instance_company_instance = Company.find_by(id: selected_purchase_instance.company_id)
  #     selected_purchase_instance.update(refunded: true)
  #     new_customer_balance = customer_instance.balance + selected_purchase_instance.amount
  #     new_company_balance = selected_purchase_instance.amount + selected_purchase_instance_company_instance.balance
  #     customer_instance.update(balance: new_customer_balance)
  #     selected_purchase_instance_company_instance.update(balance: new_company_balance)
  #     puts "Your refund for $#{selected_purchase_instance.amount} has been processed. This should reflect on your balance"
  #   end
  #   Interface.customer_main_menu
  # end

end
