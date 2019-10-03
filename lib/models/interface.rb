class Interface
    attr_reader :prompt
    attr_accessor :government, :company
    

    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts "Hello, welcome to the National Tax Service platform"
        @prompt.select("Please select the appriopriate option") do |menu|
            menu.choice "Returning Country", -> {Government.handle_returning_government} #done
            menu.choice "New Country", -> {Government.handle_new_government} #done
            menu.choice "Returning Company", -> {Company.handle_returning_company}
            menu.choice "New Company", -> {Company.handle_new_company} #done
        end
    end

    



end
