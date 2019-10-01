#create govt of three nations
3.times do
    Govt.create(name: Faker::Nation.unique.language, account_no: Faker::Bank.unique.account_number(digits: 13), tax_rate: Faker::Number.unique.between(from: 0.1, to: 0.5))
end

nation1 = Govt.first
nation2 = Govt.second
nation3 = Govt.third

#create three coompanies
3.times do
    Company.create(name: Faker::Company.unique.name, balance: Faker::Number.unique.decimal(l_digits: 6, r_digits: 2))
end

coy1 = Company.first
coy2 = Company.second
coy3 = Company.third


#Create three customers

3.times do
    Customer.create(name: Faker::Name.unique.name, acct_balance: Faker::Number.unique.decimal(l_digits: 5, r_digits: 2))
end

cust1 = Customer.first
cust2 = Customer.second
cust3 = Customer.third

#Create three purchases
amts = 3.times Faker::Number.unique.decimal(l_digits: 3, r_digits: 2)
end

Purchase.create(customer: cust1, company: coy1, amount: amts.first)
Purchase.create(customer: cust2, company: coy2, amount: amts.second)
Purchase.create(customer: cust3, company: coy3, amount: amts.third)