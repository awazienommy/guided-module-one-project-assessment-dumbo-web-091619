class Purchase < ActiveRecord::Base
    belongs_to :customers
    belongs_to :companys
end