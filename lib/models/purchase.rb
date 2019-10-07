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
end
