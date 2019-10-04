class Company < ActiveRecord::Base
  has_many :taxes
  has_many :purchases
  has_many :customers, through: :purchases
  has_many :governments, through: :taxes
  @@prompt = TTY::Prompt.new

  def self.handle_new_company
    company_name = @@prompt.ask("Welcome to the Tax Interchange. What is your company's name?")
    acct_number = @@prompt.ask("What is your company's bank account number") 
    industry = @@prompt.ask("What industry does your company operate in?") 
    location = @@prompt.ask("Where is your company located?") 
    new_company = Company.create(name: company_name, balance: 0.00, industry: industry, account_num: acct_number, location: location)
    puts "Congratulations, you have created an account for your company, #{new_company.name} with starting balance of $#{new_company.balance}."
    Interface.company_main_menu 
  end
    
  def self.handle_returning_company
    company_name = @@prompt.ask("Welcome to the Tax Interchange. What is your company's name?")
    answer = Company.find_by(name: company_name)
    if answer != nil #This catches when the country doesn't exist in the database
      puts "Welcome back #{answer.name}"
      @@prompt.select("What would you want to do today #{answer.name}?") do |menu|
        menu.choice "Check Company Balance" , -> {answer.check_balance} #done
        menu.choice "Check Total Tax Paid to date", -> {answer.taxes_payed} #done
        menu.choice "Change product price", -> {answer.change_product_price} #done
        menu.choice "Check all sales transactions", -> {answer.all_sales} #done
        menu.choice "Check total sales revenue", -> {answer.total_sales_revenue} #done
        menu.choice "Check total sales revenue less refunds", -> {answer.sales_revenue_less_refunds} #done
        menu.choice "Show all possible industries", -> {answer.get_all_industry_names} #done
        menu.choice "Find a company", -> {answer.find_company_by_name} #done
        menu.choice "See revenues by industry", -> {answer.revenue_by_industries} #done
        menu.choice "Check Tax Transactions", -> {answer.all_tax_records} #done
        menu.choice "Governments Taxes were paid to", -> {answer.tax_recieving_governments} #done

        menu.choice "Pay Tax", -> {answer.pay_tax} #done
        menu.choice "Delete company Account", -> {answer.delete_company} #done
        menu.choice "Leave Platform", -> {Interface.exit_platform} #done
      end
    end
    puts "Company not found"
    Interface.company_main_menu #send them back to the company entry menu
  end
  
  def check_balance #check balance of company
    puts "The balance of your company is $#{self.balance}"
    back_to_company_menu
  end
  
  def taxes_payed  # total taxes payed by a company
    puts "Your company has paid a total of $#{taxes.map { |tax| tax.amount}.sum} to date"
    back_to_company_menu
  end


  def change_product_price # update product price
    new_price = @@prompt.ask("What is the new product price? Type the new price in this format '00.00'")
    self.update(product_price: new_price)
    puts "Your product price has been successfully changed to #{self.product_price}"
    back_to_company_menu
  end

  def all_sales #lists all sales
    puts "Here are sales made so far"
    purchases.each_with_index  {|purchase, index| puts "#{index + 1}. Purchase Date: #{purchase.created_at}, Customer: #{Customer.find(purchase.customer_id).name}, Purchase amount: $#{purchase.purchase_amount}"}
    # binding.pry 
    back_to_company_menu
  end

  def total_sales_revenue
    total_sale_income = 0
    purchases.map {|purchase| total_sale_income += purchase.purchase_amount}
    total_sale_income
    puts "The total sales for your company amounts to $#{total_sale_income}"
    back_to_company_menu
  end

  def sales_revenue_less_refunds
    total_sale_income = 0
    purchases.map do |purchase|
      if !purchase.refunded
        total_sale_income += purchase.purchase_amount
      end
    end
    total_sale_income
    puts "The total sales for your company less revenue amounts to $#{total_sale_income}"
    back_to_company_menu
  end



  def get_all_industry_names # get a list of all industries in db
    puts "Here is the list of all industries that all companies operate in"
    Company.all.map.with_index { |company, index| puts "#{index +1}. #{company.industry}" }.uniq
    back_to_company_menu
  end

  def find_company_by_name# find a company by name
    company_searched = @@prompt.ask("What is the exact name of the company you are looking for?")
    result = Company.find_by(name: company_searched)
    if result != nil
      puts "#{result.name} was found. They are located at #{result.location} and operate in #{result.industry} industry."
    else
      puts "#{company_searched} was not found."
    end
    back_to_company_menu
  end

  def revenue_by_industries # this work
    industry_searched = @@prompt.ask("What industry are you looking at?")
    total_by_industry = 0
    Company.all.select do |company|
      if company.industry == industry_searched
        total_by_industry += company.balance
      end
    end
    puts "The total revenue of #{industry_searched} industry is $#{total_by_industry}."
    back_to_company_menu
  end

  def all_tax_records
    if !taxes.empty?
        taxes.each_with_index do |item, index|
          if Government.find_by(id: item.government_id) != nil
            government_search = Government.find_by(id: item.government_id)
            government = government_search.name
          else
            government = "Government name unavailable"
          end
          puts "#{index + 1}. Recieving Government: #{government} Transaction Date: #{item.created_at}, Amount: $#{item.amount}"
          puts
        end
    else
        puts "Your have not paid any taxes"
    end
    back_to_company_menu
  end

  def tax_recieving_governments
    if !governments.empty?
      governments.each_with_index {|government, index| puts "#{index + 1}. Government name: #{government.name}" }
    else
      puts "You have not paid taxes to any government"
    end
    back_to_company_menu
  end

  def pay_tax
      government = @@prompt.ask("What is the exact name of the Country you're paying this tax to?")
      tax_recieving_government = Government.find_by(name: government)
      tax_amount = self.balance * tax_recieving_government.tax_rate
      new_company_balance = self.balance - tax_amount
      new_government_balance = tax_recieving_government.balance + tax_amount
      Tax.create(government_id: tax_recieving_government.id, company_id: self.id, amount: tax_amount, refunded: false) 
      self.update(balance: new_company_balance)
      tax_recieving_government.update(balance: new_government_balance)
      puts "#{self.name}, thanks for paying a tax of $#{tax_amount} to #{tax_recieving_government.name} today"
      back_to_company_menu 
  end

  def delete_company
    if @@prompt.yes?("Do you want to delete all records for your company?")
      taxes.all.each {|tax| tax.delete }
      purchases.all.each {|purchase| purchase.delete }
      self.delete
      puts "Sorry to see you leave #{self.name}. Hopefully you can come back to the tax interchange later"
  elsif @@prompt.yes?("Do you want to delete just the country account and leave your records?")
      self.delete
      puts "Sorry to see you leave #{self.name}. Hopefully you can come back to the tax interchange later"
  end
      Interface.welcome #Send them back to welcome page
  end

  def back_to_company_menu
    @@prompt.select(" Welcome back #{self.name}. What else would you want to do today?") do |menu|
      menu.choice "Check Company Balance" , -> {check_balance} #done
      menu.choice "Check Total Tax Paid to date", -> {taxes_payed} #done
      menu.choice "Change product price", -> {change_product_price} #done
      menu.choice "Check all sales transactions", -> {all_sales} #done
      menu.choice "Check total sales revenue", -> {total_sales_revenue} #done
      menu.choice "Check total sales revenue less refunds", -> {sales_revenue_less_refunds} #done
      menu.choice "Show all possible industries", -> {get_all_industry_names} #done
      menu.choice "Find a company", -> {find_company_by_name} #done
      menu.choice "See revenues by industry", -> {revenue_by_industries} #done
      menu.choice "Check Tax Transactions", -> {all_tax_records} #done
      menu.choice "Governments Taxes were paid to", -> {tax_recieving_governments} #done
      menu.choice "Pay Tax", -> {pay_tax} #done
      menu.choice "Leave the interchange", -> {Interface.exit_platform} #done
    end
  end  
end
