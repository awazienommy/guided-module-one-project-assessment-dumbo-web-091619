class Govt < ActiveRecord::Base
    has_many :companys
    has_many :purchases, through: :companys
    @@prompt = TTY::Prompt.new

    def self.handle_new_govt
        puts "Welcome to the Tax Interchange. What is your country"
        country = gets.chomp
        puts "What is your country's bank account number"
        acct_number = gets.chomp
        Govt.create(name: country, account_number: acct_number)
    end

    def self.handle_returning_govt
        puts "Welcome bask. What is your country's name?"
        country = gets.chomp
        Govt.find_by(name: country)
    end

    def main_menu
        self.reload
        system "clear"
        puts "Welcome, #{self.name}!"
        @@prompt.select("What information or calculation do you want to do today?") do |menu|
            menu.choice "View companies that pay tax to your government", -> {self.display_companys}
            menu.choice "Calculate impact of tarrif on Quotes", -> {calculate_quote_impact} #proper method to be hashed out
            menu.choice "Calculate how much a customer has contributed to the national treasury", -> {calculate_contribution_of_customer} #proper method to be hashed out
            menu.choice "Trade volume between countries", -> {calculate_total_purchase_by_customers_from_a_local} #this will work if customer has location attribute.
            #that way they can be filtered by country of origin and crossed with destination govt taxes were paid
            menu.choice "All customers from a certian country"
            menu.choice "All customers that have contributed to the treasury of a destination govt"

            menu.choice "Quit", -> {exit}
        end
    end

    def display_companys
        companies = self.companys.map {|company| {company.name => company.id}}
        if companies.size == 0
            companies = ["You don't have companies contributing to your treasury"]
        end
        @@prompt.select("Choose a governemt to see more information", companies)
        self.main_menu
    end

end