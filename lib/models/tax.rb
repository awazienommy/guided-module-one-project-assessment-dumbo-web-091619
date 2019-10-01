class Tax < ActiveRecord::Base
  belongs_to :governments
  belongs_to :companies

  def self.new_tax(government_instance, company_instance, amount)
    # government_id company_id amount
    Tax.create(government_id: government_instance.id, company_id: company_instance.id, amount: amount)
  end


end
