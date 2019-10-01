class Tax < ActiveRecord::Base
  belongs_to :governments
  belongs_to :companies

  def self.new_tax(government_instance, company_instance, amount)
    # government_id company_id amount
    Tax.create(government_id: government_instance.id, company_id: company_instance.id, amount: amount)
  end


  def self.tax_by_industry(industry_string)

    company_ids = Company.all.filter { |company| company.industry == industry_string }.map { |company| company.id }
    taxes = company_ids.map { |id| Tax.all.select { |tax| tax.company_id == id } }[0]
    taxes.map { |tax| tax.amount }.sum
  end










end
