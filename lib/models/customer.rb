class Customer < ActiveRecord::Base
    has_many :purchases
    has_many :companies, through: :purchases
end
