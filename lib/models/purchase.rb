class Purchase < ActiveRecord::Base
  belongs_to :customers
  belongs_to :companies

  def self.new_purchase(company_instance, customer_instance, purchase_amount)
    Purchase.create(company_id: company_instance.id, customer_id: customer_instance.id, purchase_amount: purchase_amount)
  end


  
end
