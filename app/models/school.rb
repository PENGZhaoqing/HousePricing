class School < ActiveRecord::Base

  has_many :houses, through: :schools_houses
  has_many :schools_houses, class_name: "SchoolsHouses"

  validates :latitude, presence: true, uniqueness: true
  validates :longitude, presence: true, uniqueness: true

end
