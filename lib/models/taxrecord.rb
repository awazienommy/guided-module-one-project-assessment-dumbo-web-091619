class Taxrecord < ActiveRecord::Base
    belongs_to :government
    belongs_to :tax
end
