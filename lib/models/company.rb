class Company < ActiveRecord::Base
    belongs_to :government

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