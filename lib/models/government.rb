
require 'tty-prompt'
class Government < ActiveRecord::Base
    has_many :taxes
    has_many :companies, through: :taxes
    @@prompt = TTY::Prompt.new

    def self.handle_new_government
        country = @@prompt.ask("Welcome to the Tax Interchange. What is your country's name?")
        acct_number = @@prompt.ask("What is your country's bank account number") 
        new_govt = Government.create(name: country, balance: 0.00, account_num: acct_number)
        system "clear"
        puts "----------------------------"
        puts "Congratulations, you have created an account for your country, #{new_govt.name} with starting balance of $#{new_govt.balance}."
        Interface.government_main_menu
    end

    def self.handle_returning_government
        country = @@prompt.ask("Welcome back. What is your country's name?")
         answer = Government.find_by(name: country)
         if answer != nil #This catches when the country doesn't exist in the database
            @@prompt.select(" Welcome back #{answer.name}, What would you want to do today?") do |menu|
                menu.choice "Check Country Balance" , -> {answer.check_balance} #done
                menu.choice "Check Tax Transactions", -> {answer.all_tax_records} #done
                menu.choice "Tax a company", -> {answer.tax_a_company} #done
                menu.choice "Change Tax rate", -> {answer.change_tax_rate} #done
                menu.choice "Show companies that have paid taxes to Our Goverment", -> {answer.companies_paying_taxes} #done
                menu.choice "Delete Country Account", -> {answer.delete_country} #done
                menu.choice "Go back to welcome screen", -> {Interface.welcome} #done
                menu.choice "Leave the interchange", -> {Interface.exit_platform} #done
            end
        end
        system "clear"
        puts "----------------------------"
        puts "Country not found"
        Interface.government_main_menu #send them back to the government entry menu
        
    end
    
    def check_balance
        system "clear"
        puts "----------------------------"
        puts "The balance of your country's governement is $#{self.balance}"
        back_to_government_menu
    end

    def all_tax_records
        if !taxes.empty?
            system "clear"
            puts "----------------------------"
            taxes.each_with_index do |item, index|
                puts "#{index + 1}. Paying Company: #{Company.find(item.company_id).name} Transaction Date: #{item.created_at}, Amount: $#{item.amount}"
            end
        else
            system "clear"
            puts "----------------------------"
            puts "Your government have not recieved any taxes"
        end
        back_to_government_menu
    end

    def tax_a_company
        company = @@prompt.ask("What is the name of the company you want to tax?")
        if company_to_be_taxed = Company.find_by(name: company)
            tax_amount = company_to_be_taxed.balance * self.tax_rate
            new_company_balance = company_to_be_taxed.balance - tax_amount
            new_government_balance = self.balance + tax_amount
            Tax.create(government_id: self.id, company_id: company_to_be_taxed.id, amount: tax_amount) 
            company_to_be_taxed.update(balance: new_company_balance)
            self.update(balance: new_government_balance)
            system "clear"
            puts "----------------------------"
            puts "\n#{self.name} has just recieved a tax of $#{tax_amount} from #{company_to_be_taxed.name}"
        end
        back_to_government_menu
    end

    def change_tax_rate
        old_rate = self.tax_rate
        new_rate_input = @@prompt.ask("What is the new Tax Rate? Please type in numbers only", convert: :float)
        new_rate = new_rate_input / 100
        self.update(tax_rate:  new_rate)
        system "clear"
        puts "----------------------------"
        puts "Hi #{self.name}, you have successfully changed your country's tax rate from #{old_rate * 100}% to #{new_rate * 100}%."
        back_to_government_menu
    end

    def companies_paying_taxes
        if companies.empty?
            system "clear"
            puts "----------------------------"
            puts "Your governement has no company paying revenue to it"
        else
            names = companies.map {|company| company.name}.uniq
            system "clear"
            puts "----------------------------"
            names.each_with_index {|company, index| puts "#{index + 1}. Company name: #{company}"}
        end
        back_to_government_menu
    end

    def delete_country
        if @@prompt.yes?("Do you want to delete all records for your country?")
            taxes.all.each {|tax| tax.delete }
            self.delete
            system "clear"
            puts "----------------------------"
            puts "Sorry to see you leave #{self.name}. Hopefully you can come back to the tax interchange later"
        elsif @@prompt.yes?("Do you want to delete just the country account and leave your records?")
            self.delete
            system "clear"
            puts "----------------------------"
            puts "Sorry to see you leave #{self.name}. Hopefully you can come back to the tax interchange later"
        end
            Interface.welcome #Send them back to welcome page
    end
    
    def back_to_government_menu
        @@prompt.select(" Welcome back #{self.name}. What else would you want to do today?") do |menu|
            menu.choice "Check Country Balance" , -> {check_balance} #done
            menu.choice "Check Tax Transactions", -> {all_tax_records} #done
            menu.choice "Tax a company", -> {tax_a_company} #done
            menu.choice "Change Tax rate", -> {change_tax_rate} #done
            menu.choice "Show companies that have paid taxes to Our Goverment", -> {companies_paying_taxes} #done
            menu.choice "Delete Country Account", -> {delete_country} #done
            menu.choice "Go back to welcome screen", -> {Interface.welcome} #done
            menu.choice "Leave the interchange", -> {Interface.exit_platform} #done
        end
    end
    
end