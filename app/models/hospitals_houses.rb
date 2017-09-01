class HospitalsHouses < ActiveRecord::Base

  belongs_to :hospital
  belongs_to :house

end
