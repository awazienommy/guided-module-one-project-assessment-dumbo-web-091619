class Interface
    attr_reader :prompt
    attr_accessor :government

    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts "Hello, welcome to the National Tax Service platform"
        @prompt.select("Please select the appriopriate option") do |menu|
            puts "Chose one of the follwing if you are a Country"
            menu.choice "Returning Country", -> {Government.handle_returning_government}
            menu.choice "New Country", -> {Government.handle_new_government}
            puts "Chose one of the follwing if you are a company"
            menu.choice "Returning Company", -> {Company.handle_returning_company}
            menu.choice "New Company", -> {Company.handle_new_company}
        end
    end


end
