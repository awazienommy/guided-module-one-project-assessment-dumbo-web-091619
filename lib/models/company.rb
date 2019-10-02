class Company < ActiveRecord::Base
    belongs_to :government

    has_many :taxes
    has_many :companies, through: :taxes
end


def self.handle_new_company
    puts "Welcome to the Tax Interchange. What is your company's name?"
    company_name_input = gets.chomp
    puts "What is your company's bank account number?"
    acct_number_input = gets.chomp
    puts "What industry does your company operate in?"
    industry_input = gets.chomp
    puts "Where is your company located?"
    location_input = gets.chomp
    new_company = Company.create(name: company_name_input, balance: 0.00, industry: industry_input, account_num: acct_number, location: location_input)
    return "#{new_company.name}, Welcome to the International Tax Exchange. Your starting balance is $#{new_company.balance}."
end

def self.handle_returning_company
    puts "Welcome back. What is your company's name?"
    company = gets.chomp
    answer = Company.find_by(name: company)
    puts "Welcome back #{answer.name}"
    @@prompt.select("What would you want to do today #{answer.name}?") do |menu|
        menu.choice "Check Country Balance" , -> {answer.balance}
        menu.choice "Check Tax Transactions"#, -> {self.all_taxes}
        #menu.choice "Pay Tax"#, -> {Government.h} #get agreement on it
        #menu.choice "Delete company Account", -> {Government.handle_new_government}
        #above can be implemented by adding a column in the table indicating whether still in business or not
        menu.choice "Exit"#, -> {Government.handle_new_government}
    end



    def self.all_taxes
        Taxrecord.select {|item| item.company == self.name}
    end

    def governments_taxes_were_paid_to
        self.all_taxes.map {|tax| tax.government}
end