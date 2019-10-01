#create Government of three nations
Government.destroy_all
Company.destroy_all
Customer.destroy_all
# Purchase.destroy_all
# Tax.destroy_all

# create governments
# name balance account_num
usa = Government.create(name: "USA", balance: 1000, account_num: 1234567891011)
france = Government.create(name: "France", balance: 1000, account_num: 1110987654321)
britain = Government.create(name: "Britain", balance: 1000, account_num: 1211109876543)



#create companies
# name balance industry account_num location
microsoft = Company.create(name: "Microsoft", balance: 1000, industry: "Tech", account_num: 1234567890102, location: "Seattle")
google = Company.create(name: "Google", balance: 1000, industry: "Tech", account_num: 58304598938584, location: "Silicon Valley")
ford = Company.create(name: "Ford", balance: 1000, industry: "Automotive", account_num: 854739275839259, location: "Detroit")
boeing = Company.create(name: "Boeing", balance: 1000, industry: "Aerospace", account_num: 85437390458059, location: "Seattle")
sweetgreen = Company.create(name: "SweetGreen", balance: 1000, industry: "Food", account_num: 9987623547263484, location: "New York")


#Create customers
# name balance account_num salary
lyle = Customer.new(name: "Lyle", balance: 100, account_num: 12345678909871, salary: 100)
alex = Customer.new(name: "Alex", balance: 100, account_num: 12345678909872, salary: 100)
nicky = Customer.new(name: "Nicky", balance: 100, account_num: 12345678909873, salary: 100)
gracie = Customer.new(name: "Gracie", balance: 100, account_num: 12345678909874, salary: 100)
eric = Customer.new(name: "Eric", balance: 100, account_num: 42345678909874, salary: 100)
chinomnso = Customer.new(name: "Chinomnso", balance: 100, account_num: 12345678909875, salary: 100)
reina = Customer.new(name: "Reina", balance: 100, account_num: 12345678909876, salary: 100)
rob = Customer.new(name: "Rob", balance: 100, account_num: 12345678909877, salary: 100)
adeja = Customer.new(name: "Adeja", balance: 100, account_num: 12345678909878, salary: 100)
pavel = Customer.new(name: "Pavel", balance: 100, account_num: 12345678909879, salary: 100)






#Create three purchases
# amts = 3.times Faker::Number.unique.decimal(l_digits: 3, r_digits: 2)
# end
#
# Purchase.create(customer: cust1, company: coy1, amount: amts.first)
# Purchase.create(customer: cust2, company: coy2, amount: amts.second)
# Purchase.create(customer: cust3, company: coy3, amount: amts.third)
