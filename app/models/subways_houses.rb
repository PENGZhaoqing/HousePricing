class SubwaysHouses < ActiveRecord::Base

  belongs_to :subway
  belongs_to :house

end
