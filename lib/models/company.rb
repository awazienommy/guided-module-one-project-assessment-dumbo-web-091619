class Company < ActiveRecord::Base
    belongs_to :government

    has_many :taxes
    has_many :companies, through: :taxes
end
