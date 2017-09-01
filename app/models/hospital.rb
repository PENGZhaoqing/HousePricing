class Hospital < ActiveRecord::Base

  has_many :houses, through: :hospitals_houses
  has_many :hospitals_houses, class_name: "HospitalsHouses"

  validates :latitude, presence: true, uniqueness: true
  validates :longitude, presence: true, uniqueness: true
end
