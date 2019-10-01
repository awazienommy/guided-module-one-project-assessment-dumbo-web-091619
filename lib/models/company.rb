class Company < ActiveRecord::Base
    belongs_to :govt

    has_many :purchases
    has_many :customers, through: :purchases
end