class Government < ActiveRecord::Base
    has_many :companies
    has_many :purchases, through: :companies
    @@prompt = TTY::Prompt.new

    def self.handle_new_government
        puts "Welcome to the Tax Interchange. What is your country's name?"
        country = gets.chomp
        puts "What is your country's bank account number"
        acct_number = gets.chomp
        Government.create(name: country, balance: 0.00, account_num: acct_number)
    end

    def self.handle_returning_government
        puts "Welcome back. What is your country's name?"
        country = gets.chomp
        answer = Government.find_by(name: country)
        puts "Welcome back #{answer.name}"
        @@prompt.select("What would you want to do today #{answer.name}?") do |menu|
            menu.choice "Check Country Balance" , -> {answer.balance}
            menu.choice "Check Tax Transactions", -> {self.all_taxes}
            menu.choice "Tax a company", -> {self.tax_a_company}
            menu.choice "Change Tax rate", -> {self.change_tax_rate}
            #menu.choice "Show companies that have paid taxes to Our Goverment", -> {self.all_taxes_company_names}
            #get agreement on this
            menu.choice "Delete Country Account", -> {self.delete}  #find out if the proc will actually take out the 
            #record from the db
            menu.choice "Exit"#, -> {Government.handle_new_government}
        end
    end


    def self.all_taxes
        Taxrecord.select {|item| item.governemt == self.name}
    end

    def companies_paying_taxes
        self.all_taxes.map {|tax| tax.company}
    end

    def self.change_tax_rate
        puts "What is the new Tax Rate? Please make in the format of "00.00""
        new_rate_input = Float(gets.chomp)
        self.tax_rate = new_rate_input
        self.save
    end


    def self.tax_a_company
        puts "What is the company name you want to tax?"
        company = gets.chomp
        company_to_be_taxed = Company.find_by_name(name: company)
        tax_amount = company_to_be_taxed.balance * self.tax_rate
        Taxrecord.create(self.name, company_to_be_taxed.name, Time.now, tax_amount) 
        #company_to_be_taxed.name can be replaced with company, but I want to reduce human error and enforce 
        #data being drawn only from the database
        Self.balance += tax_amount
        Self.save
    end




    # def main_menu
    #     self.reload
    #     system "clear"
    #     puts "Welcome, #{self.name}!"
    #     @@prompt.select("What do you want to do today?") do |menu| #find a way to divy this up into companies and countrys/governments using TTY

    #         #Choices for governments
    #         menu.choice "View companies that pay tax to your government", -> {self.display_companys}
    #         menu.choice "Calculate how much a customer has contributed to the national treasury", -> {calculate_contribution_of_customer} #proper method to be hashed out
    #         menu.choice "Trade volume between countries", -> {calculate_total_purchase_by_customers_from_a_local} #this will work if customer has location attribute.
    #         menu.choice "All customers that have contributed to the treasury of a destination government"
    #         menu.choice "Remove country from Tax Interchange", -> {drop country} #this will remove the country item from the database
    #         menu.choice "All customers from a certian country"
    #         menu.choice "Quit", -> {exit}

    #         #Choices for companies
    #         menu.choice "Pay taxes", -> {company_pays_tax_to_chosen_government} #This will validate account number of the recieving government, make sure co has enough money to pay taxes, decreases company balance and increases chosen country/government balance
    #         menu.choice "Calculate impact of tarrif on Quotes", -> {calculate_quote_impact} #proper method to be hashed out
    #         #that way they can be filtered by country of origin and crossed with destination government taxes were paid
    #         menu.choice "Quit", -> {exit}
    #     end
    # end

    def display_companys
        companies = self.companys.map {|company| {company.name => company.id}}
        if companies.size == 0
            companies = ["You don't have companies contributing to your treasury"]
        end
        @@prompt.select("Choose a governemt to see more information", companies)
        self.main_menu
    end

end
