class Subway < ActiveRecord::Base

  has_many :houses, through: :subways_houses
  has_many :subways_houses, class_name: "SubwaysHouses"

  validates :latitude, presence: true, uniqueness: true
  validates :longitude, presence: true, uniqueness: true
end
