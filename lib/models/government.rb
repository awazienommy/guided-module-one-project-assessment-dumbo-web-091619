
require 'tty-prompt'
class Government < ActiveRecord::Base
    has_many :companies
    has_many :purchases, through: :companies
    @@prompt = TTY::Prompt.new

    def self.handle_new_government
        country = @@prompt.ask("Welcome to the Tax Interchange. What is your country's name?")
        acct_number = @@prompt.ask("What is your country's bank account number") 
        Government.create(name: country, balance: 0.00, account_num: acct_number)
        puts "Congratulations, you have created an account for your country with starting balance of $#{self.balance}."
        #code (prompt) to either exit platform or go back to countries menu
    end

    #To chose yes or no @@prompt.yes?  can set it to a variable and use that variable for further manipulation. it returns true or false

    def self.handle_returning_government
        country = @@prompt.ask("Welcome back. What is your country's name?")
        answer = Government.find_by(name: country)
        @@prompt.select(" Welcome back #{answer.name}, What would you want to do today?") do |menu|
            menu.choice "Check Country Balance" , -> {answer.check_balance} #done
            menu.choice "Check Tax Transactions", -> {answer.all_tax_records} #done
            menu.choice "Tax a company", -> {answer.tax_a_company} #done
            menu.choice "Change Tax rate", -> {answer.change_tax_rate} #done
            menu.choice "Show companies that have paid taxes to Our Goverment", -> {answer.companies_paying_taxes} #done
            menu.choice "Delete Country Account", -> {answer.delete_country} #done
            menu.choice "Leave the interchange", -> {answer.exit_platform} #done
        end
    end
    

    def check_balance
        puts "The balance of your country's governement is $#{self.balance}"
        #code (prompt) to either exit platform or go back to countries menu
    end

    def all_tax_records
        count = 1
       Tax.select do |item| 
            if item.government_id == self.id
                company = Company.find_by(id: item.company_id)
                puts "#{count}. Paying Company:#{company.name} Transaction Date: #{item.created_at} Amount Paid: $#{item.amount}"
                puts
                count += 1
            end
        end
        #code (prompt) to either exit platform or go back to countries menu
    end

    def tax_a_company
        company = @@prompt.ask("What is the name of the company you want to tax?")
        company_to_be_taxed = Company.find_by(name: company)
        tax_amount = company_to_be_taxed.balance * self.tax_rate
        new_company_balance = company_to_be_taxed.balance - tax_amount
        new_government_balance = self.balance + tax_amount
        Tax.create(government_id: self.id, company_id: company_to_be_taxed.id, amount: tax_amount) 
        company_to_be_taxed.update(balance: new_company_balance)
        self.update(balance: new_government_balance)
        #code (prompt) to either exit platform or go back to countries menu
    end

    def change_tax_rate
        old_rate = self.tax_rate
        new_rate = @@prompt.ask("What is the new Tax Rate? Please make in the format of 00.00", convert: :float)
        self.update(tax_rate:  new_rate)
        puts "You have successfully changed your country's tax rate from #{old_rate} to #{new_rate}."
        #code (prompt) to either exit platform or go back to countries menu
    end

    def companies_paying_taxes
        companies = []
            Tax.select do |item| 
                if item.government_id == self.id
                companies << Company.find_by(id: item.company_id).name
                end
            end
        if companies.empty?
            puts "Your governement has no company paying revenue to it"
        else
            puts companies.uniq
        end
        #code (prompt) to either exit platform or go back to countries menu
    end

    def delete_country
        if @@prompt.yes?("Are you sure you want to remove your governement from the platform?")
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
