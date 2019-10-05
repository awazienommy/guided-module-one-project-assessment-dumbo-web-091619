class Products < ActiveRecord::Base
    belongs_to :governments
    belongs_to :companies
    @@prompt = TTY::Prompt.new

    def self.new_product
        #this can only be called by company, so use self.id for the company_id
        product_name = @@prompt.ask("What is the name of this new product?")
        price = @@prompt.ask("What is the price of the new product you want to add?")
        country = @@prompt.ask("What is the country of origin?")
        govt_id = Government.find_by(name: country).id
        Product.create(name: product_name, product_price: price, government_id: govt_id, company_id: self.id)
        system "clear"
        puts "______________________________"
        puts "Hi, you have created #{self.name} with price of #{self.product_price}"
        Interface.company_main_menu
    end






end