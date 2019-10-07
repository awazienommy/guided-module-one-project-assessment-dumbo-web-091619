class Interface
    attr_reader :prompt
    attr_accessor :government, :company
    @@prompt = TTY::Prompt.new

    
    def initialize
        @@prompt = TTY::Prompt.new
    end

    def self.welcome
        puts "Hello, welcome to the National Tax Service platform"
        @@prompt.select("Please select option that best describes you") do |menu|
            menu.choice "Country or government", -> {government_main_menu}
            menu.choice "A Company", -> {company_main_menu}
            menu.choice "Individual", -> {customer_main_menu}
            menu.choice "Exit Interchange Plaform", -> {exit_platform}

        end
    end

    def self.government_main_menu
        @@prompt.select("Hi Country, which one are you?") do |menu|
            menu.choice "Returning Country/Government", -> {Government.handle_returning_government} #done
            menu.choice "New Country/Governmnent", -> {Government.handle_new_government} #done
            menu.choice "Go back to welcome screen", -> {welcome} #done

        end
    end

    def self.customer_main_menu
        @@prompt.select("Welcome to Tax Interchange, what would you want to do today?") do |menu|
            menu.choice "Make a purchase", -> {Customer.new_purchase}
            menu.choice "Return a purchase", -> {Customer.make_return}
            menu.choice "List purchases", -> {Customer.list_of_purchases}
            menu.choice "How much have I spent in total?", -> {Customer.total_amount_spent}
            menu.choice "What is my average spending?", -> {Customer.average_amount_spent}
            menu.choice "Earn money", -> {Customer.do_work}
            menu.choice "Close account", -> {Customer.close_account}
            menu.choice "Go back to welcome screen", -> {welcome} #done

        end
    end

    def self.company_main_menu
        @@prompt.select("Hi Company, select the option that applies to you") do |menu|
            menu.choice "Returning Company", -> {Company.handle_returning_company}
            menu.choice "New Company", -> {Company.handle_new_company} #done
            menu.choice "Go back to welcome screen", -> {welcome} #done
        end
    end

    
    
    def self.exit_platform
        puts "Thanks for using the Tax Exchange platform today"
        exit
    end
end
