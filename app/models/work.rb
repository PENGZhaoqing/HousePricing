class Work < ActiveRecord::Base

  has_many :houses, through: :works_houses
  has_many :works_houses, class_name: "WorksHouses"

  validates :latitude, presence: true, uniqueness: true
  validates :longitude, presence: true, uniqueness: true
end
