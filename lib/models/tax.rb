class Tax < ActiveRecord::Base
  belongs_to :governments
  belongs_to :companies


end
