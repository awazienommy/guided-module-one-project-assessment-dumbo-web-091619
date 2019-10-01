class Customer < ActiveRecord::Base
    has_many :purchases
    has_many :companys, through: :purchases
end