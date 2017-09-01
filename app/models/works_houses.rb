class WorksHouses < ActiveRecord::Base

  belongs_to :work
  belongs_to :house

end
