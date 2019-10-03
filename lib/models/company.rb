class Company < ActiveRecord::Base
  has_many :taxes
  has_many :purchases
  has_many :customers, through: :purchases
  @@prompt = TTY::Prompt.new


  def change_product_price(new_price)
    # update product price
    self.product_price = new_price
  end

  def product_price_change
    new_price = @@prompt.ask("What is the new product price? Write in in this format '00.00'")
    self.update(product_price: new_price)
    puts "Your product price has been successfully changed to #{self.product_price}"
    #code to get back to the company menu
  end




  def all_sales
    # get all sales for the company
    self.purchases
  end

  def sales_by_company
    total_sale = 0
    sales = Purchase.select(company_id: self.id)
        self.each do |sale|
            total_sale += sale.purchase_amount
        end
    puts "The total sales for your company amounts to $#{total_sale}"
  end

  def sales_revenue
    # generate revenue for all sales for a company. need to add logic to not count sales that are refunded
    all_sales.map { |sale| sale.purchase_amount }.sum
  end

  def sales_less_returns

  end


  def taxes_payed
    # total taxes payed for a company
    self.taxes.map { |tax| tax.amount}.sum
  end


  def self.close_account(id)
    # destroy company
    Company.destroy(id)
  end


  def self.get_all_industry_names
    # get a list of all industries in db
    Company.all.map { |company| company.industry }.uniq
  end


  def self.revenue_all_industries
    # this doesn't work
    Company.get_all_industry_names.each do |name|
      Purchase.revenue_by_industry(name)
    end
  end


  def self.find_by_name(name_string)
    # find a company by name
    Company.all.filter { |company| company.name == name_string }
  end

    has_many :taxes
    has_many :companies, through: :taxes
    @@prompt = TTY::Prompt.new




    def self.handle_new_company
        company_name = @@prompt.ask("Welcome to the Tax Interchange. What is your company's name?")
        acct_number = @@prompt.ask("What is your company's bank account number") 
        industry = @@prompt.ask("What industry does your company operate in?") 
        location = @@prompt.ask("Where is your company located?") 
        new_company = Company.create(name: company_name, balance: 0.00, industry: industry, account_num: acct_number, location: location)
        puts "Congratulations, you have created an account for your compny with starting balance of $#{new_company.balance}."
    end

    def self.handle_returning_company
        company_name = @@prompt.ask("Welcome to the Tax Interchange. What is your company's name?")
        answer = Company.find_by(name: company_name)
        puts "Welcome back #{answer.name}"
        @@prompt.select("What would you want to do today #{answer.name}?") do |menu|
            menu.choice "Check Company Balance" , -> {answer.check_balance} #done
            menu.choice "Check Tax Transactions", -> {answer.all_tax_records} #done
            menu.choice "Governments Taxes were paid to", -> {answer.tax_recieving_governments} #done
            menu.choice "Pay Tax", -> {answer.pay_tax} #done
            menu.choice "Delete company Account", -> {answer.delete_company} #done
            menu.choice "Exit", -> {answer.exit_platform} #done
        end
    end

    def check_balance
        puts "The balance of your company is $#{self.balance}"
        #code (prompt) to either exit platform or go back to countries menu
    end

    def all_tax_records
        count = 1
       Tax.select do |item| 
            if item.company_id == self.id
                government = Government.find_by(id: item.government_id)
                puts "#{count}. Recieving Governement: #{government.name} Transaction Date: #{item.created_at} Amount Paid: $#{item.amount}"
                # binding.pry
                puts
                count += 1
            end
        end
        #code (prompt) to either exit platform or go back to countries menu
    end

    def tax_recieving_governments
        governments = []
            Tax.select do |item| 
                if item.company_id == self.id
                governments << Government.find_by(id: item.government_id).name
                end
            end
        if governments.empty?
            puts "Your company ain't paid shit to nobody"
        else
            puts governments.uniq
        end
        #code (prompt) to either exit platform or go back to countries menu
    end

    def pay_tax
        government = @@prompt.ask("What is the name of the Country you're paying to?")
        tax_recieving_government = Government.find_by(name: government)
        tax_amount = self.balance * tax_recieving_government.tax_rate
        new_company_balance = self.balance - tax_amount
        new_government_balance = tax_recieving_government.balance + tax_amount
        Tax.create(government_id: tax_recieving_government.id, company_id: self.id, amount: tax_amount) 
        self.update(balance: new_company_balance)
        tax_recieving_government.update(balance: new_government_balance)
        puts "#{self.name}, thanks for paying your taxes today"
        #code (prompt) to either exit platform or go back to countries menu
    end

    def delete_company
        if @@prompt.yes?("Are you sure you want to remove your company from the platform?")
            self.delete
            puts "Sorry to see you leave #{self.name}. Hopefully you can come back to the tax interchange later"
        end
        #put and else statement to take user back to countries menu if they chose no
        #code to go back to welcome menu
    end

    def exit_platform
        puts "Thanks for using the Tax Exchange platform today"
        exit
    end
end
