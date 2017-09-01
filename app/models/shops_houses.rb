class ShopsHouses < ActiveRecord::Base

  belongs_to :shop
  belongs_to :house

end
