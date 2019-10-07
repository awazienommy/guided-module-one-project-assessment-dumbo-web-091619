class Tax < ActiveRecord::Base
  belongs_to :government
  belongs_to :company

end
