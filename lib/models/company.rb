class Company < ActiveRecord::Base
    belongs_to :govt

    has_many :taxs
    has_many :company, through: :taxs
end