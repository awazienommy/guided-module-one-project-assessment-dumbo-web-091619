class Tax < ActiveRecord::Base
  belongs_to :government
  belongs_to :company

  def self.new_tax(government_instance, company_instance, amount)
    # government_id company_id amount
    # create new tax object
    Tax.create(government_id: government_instance.id, company_id: company_instance.id, amount: amount)
  end


  def self.amount_of_tax_by_industry(industry_string)
    # calculate total tax for passed in industry name
    companies = Company.all.filter { |company| company.industry == industry_string }
    companies.map { |company| company.taxes }[0].map { |tax| tax.amount }.sum
  end










end
