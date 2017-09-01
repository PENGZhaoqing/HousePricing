class Bus < ActiveRecord::Base

  has_many :houses, through: :buses_houses
  has_many :buses_houses, class_name: "BusesHouses"

  validates :latitude, presence: true, uniqueness: true
  validates :longitude, presence: true, uniqueness: true

end
