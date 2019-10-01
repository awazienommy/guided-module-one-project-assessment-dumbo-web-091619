require_relative '../config/environment'

interface = interface.new
loggedInGovt = interface.welcome()

while loggedInGovt.nil?
    loggedInGovt = interface.welcome()
end

interface.govt = loggedInGovt
interface.govt.main_menu

binding.pry

puts "hello world"
