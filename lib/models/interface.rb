class Interface
    attr_reader :prompt
    attr_accessor :govt

    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts "Hello, welcome to the National Tax Service platform"
        @prompt.select("Are you a returning Country or a new Country?") do |menu|
            menu.choice "Returning Country", -> {Govt.handle_returning_govt}
            menu.choice "New Country", -> {Govt.handle_new_govt}
        end
    end


end