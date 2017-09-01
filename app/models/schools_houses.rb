class SchoolsHouses < ActiveRecord::Base

  belongs_to :school
  belongs_to :house

end
