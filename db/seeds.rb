# Destroy all instances in database before seeding
Government.destroy_all
Company.destroy_all
Customer.destroy_all
Purchase.destroy_all
Tax.destroy_all


# governments = ["France", "Britain", "USA"]


# create governments
# name balance account_num
<<<<<<< HEAD
usa = Government.create(name: "USA", balance: Faker::Number.decimal(l_digits: 8, r_digits: 2), account_num: Faker::Number.unique.number(digits: 13))
france = Government.create(name: "France", balance: Faker::Number.decimal(l_digits: 6, r_digits: 2), account_num: Faker::Number.unique.number(digits: 13))
britain = Government.create(name: "Britain", balance: Faker::Number.decimal(l_digits: 6, r_digits: 2), account_num: Faker::Number.unique.number(digits: 13))

=======
usa = Government.create(name: "USA", balance: 1000, account_num: 1234567891011, tax_rate: 0.00)
france = Government.create(name: "France", balance: 1000, account_num: 1110987654321, tax_rate: 0.03)
britain = Government.create(name: "Britain", balance: 1000, account_num: 1211109876543, tax_rate: 0.04)
>>>>>>> chinomnso

# Chooses a company at random and returns an array
def choose_one_company
  Company.all.sample(1)
end


# Chooses a customer at random and returns an array
def choose_one_customer
  Customer.all.sample(1)
end

def choose_one_government
  Government.all.sample(1)
end


#create companies
# name balance industry account_num location
def create_company
 Company.create(name:  Faker::Space.star_cluster + ' ' + Faker::Space.moon,
                balance: Faker::Number.decimal(l_digits: 6, r_digits: 2),
                industry: Faker::Company.industry,
                account_num: Faker::Number.unique.number(digits: 13),
                location: Faker::Nation.capital_city)
end


#Create customers
# name balance account_num salary
def create_customer
  Customer.create(name: Faker::Name.unique.name_with_middle,
                  balance: Faker::Number.decimal(l_digits: 4, r_digits: 2),
                  account_num: Faker::Number.unique.number(digits: 13),
                  salary: Faker::Number.decimal(l_digits: 4, r_digits: 2))
end


# Create purchases
# company_id customer_id purchase_amount
def create_purchase
  Purchase.create(company_id: choose_one_company[0].id,
                  customer_id: choose_one_customer[0].id,
                  purchase_amount: Faker::Number.decimal(l_digits: 3, r_digits: 2))
end


# Create taxes
# company_id government_id amount
def create_tax
  Tax.create(company_id: choose_one_company[0].id,
             government_id: choose_one_government[0].id,
             amount: Faker::Number.decimal(l_digits: 3, r_digits: 2))
end


50.times { create_company }
100.times { create_customer }
500.times { create_purchase }
500.times { create_tax }


puts "---------------------------------------------------------"
puts "                    DB Seeded                            "
puts "---------------------------------------------------------"
