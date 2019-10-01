#create Government of three nations
Government.destroy_all
Company.destroy_all
Customer.destroy_all
Purchase.destroy_all
Tax.destroy_all

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
lyle = Customer.create(name: "Lyle", balance: 100, account_num: 12345678909871, salary: 100)
alex = Customer.create(name: "Alex", balance: 100, account_num: 12345678909872, salary: 100)
nicky = Customer.create(name: "Nicky", balance: 100, account_num: 12345678909873, salary: 100)
gracie = Customer.create(name: "Gracie", balance: 100, account_num: 12345678909874, salary: 100)
eric = Customer.create(name: "Eric", balance: 100, account_num: 42345678909874, salary: 100)
chinomnso = Customer.create(name: "Chinomnso", balance: 100, account_num: 12345678909875, salary: 100)
reina = Customer.create(name: "Reina", balance: 100, account_num: 12345678909876, salary: 100)
rob = Customer.create(name: "Rob", balance: 100, account_num: 12345678909877, salary: 100)
adeja = Customer.create(name: "Adeja", balance: 100, account_num: 12345678909878, salary: 100)
pavel = Customer.create(name: "Pavel", balance: 100, account_num: 12345678909879, salary: 100)






#Create purchases
# company_id customer_id purchase_date purchase_amount
#need to update the schema so that purchase date creates an automatic timestamp on creation
Purchase.create(company_id: microsoft.id, customer_id: lyle.id, purchase_amount: 10)
Purchase.create(company_id: boeing.id, customer_id: alex.id, purchase_amount: 10)
Purchase.create(company_id: boeing.id, customer_id: reina.id, purchase_amount: 10)
Purchase.create(company_id: microsoft.id, customer_id: rob.id, purchase_amount: 10)
Purchase.create(company_id: google.id, customer_id: adeja.id, purchase_amount: 10)
Purchase.create(company_id: google.id, customer_id: pavel.id, purchase_amount: 10)
Purchase.create(company_id: boeing.id, customer_id: nicky.id, purchase_amount: 10)
Purchase.create(company_id: microsoft.id, customer_id: gracie.id, purchase_amount: 10)
Purchase.create(company_id: sweetgreen.id, customer_id: chinomnso.id, purchase_amount: 10)
Purchase.create(company_id: sweetgreen.id, customer_id: eric.id, purchase_amount: 10)
Purchase.create(company_id: microsoft.id, customer_id: lyle.id, purchase_amount: 10)
Purchase.create(company_id: ford.id, customer_id: alex.id, purchase_amount: 10)
Purchase.create(company_id: boeing.id, customer_id: reina.id, purchase_amount: 10)
Purchase.create(company_id: microsoft.id, customer_id: rob.id, purchase_amount: 10)
Purchase.create(company_id: ford.id, customer_id: adeja.id, purchase_amount: 10)
Purchase.create(company_id: microsoft.id, customer_id: pavel.id, purchase_amount: 10)
Purchase.create(company_id: ford.id, customer_id: nicky.id, purchase_amount: 10)
Purchase.create(company_id: ford.id, customer_id: gracie.id, purchase_amount: 10)
Purchase.create(company_id: sweetgreen.id, customer_id: chinomnso.id, purchase_amount: 10)
Purchase.create(company_id: ford.id, customer_id: eric.id, purchase_amount: 10)
Purchase.create(company_id: ford.id, customer_id: lyle.id, purchase_amount: 10)
Purchase.create(company_id: ford.id, customer_id: alex.id, purchase_amount: 10)
Purchase.create(company_id: sweetgreen.id, customer_id: reina.id, purchase_amount: 10)
Purchase.create(company_id: ford.id, customer_id: rob.id, purchase_amount: 10)
Purchase.create(company_id: ford.id, customer_id: adeja.id, purchase_amount: 10)





# create taxes
# government_id company_id amount
Tax.create(company_id: microsoft.id, government_id: usa.id, amount: 10)
Tax.create(company_id: boeing.id, government_id: france.id, amount: 10)
Tax.create(company_id: boeing.id, government_id: britain.id, amount: 10)
Tax.create(company_id: microsoft.id, government_id: usa.id, amount: 10)
Tax.create(company_id: google.id, government_id: france.id, amount: 10)
Tax.create(company_id: google.id, government_id: britain.id, amount: 10)
Tax.create(company_id: boeing.id, government_id: usa.id, amount: 10)
Tax.create(company_id: microsoft.id, government_id: france.id, amount: 10)
Tax.create(company_id: sweetgreen.id, government_id: britain.id, amount: 10)
Tax.create(company_id: sweetgreen.id, government_id: usa.id, amount: 10)
Tax.create(company_id: microsoft.id, government_id: france.id, amount: 10)
Tax.create(company_id: ford.id, government_id: britain.id, amount: 10)
Tax.create(company_id: boeing.id, government_id: usa.id, amount: 10)
Tax.create(company_id: microsoft.id, government_id: france.id, amount: 10)
Tax.create(company_id: ford.id, government_id: britain.id, amount: 10)
Tax.create(company_id: microsoft.id, government_id: usa.id, amount: 10)
Tax.create(company_id: ford.id, government_id: france.id, amount: 10)
Tax.create(company_id: ford.id, government_id: britain.id, amount: 10)
Tax.create(company_id: sweetgreen.id, government_id: usa.id, amount: 10)
Tax.create(company_id: ford.id, government_id: france.id, amount: 10)
Tax.create(company_id: ford.id, government_id: britain.id, amount: 10)
Tax.create(company_id: ford.id, government_id: france.id, amount: 10)
Tax.create(company_id: sweetgreen.id, government_id: usa.id, amount: 10)
Tax.create(company_id: ford.id, government_id: france.id, amount: 10)
Tax.create(company_id: ford.id, government_id: britain.id, amount: 10)



puts "---------------------------------------------------------"
puts "                    DB Seeded                            "
puts "---------------------------------------------------------"
