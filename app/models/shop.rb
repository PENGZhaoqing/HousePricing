class Shop < ActiveRecord::Base
  has_many :houses, through: :shops_houses
  has_many :shops_houses, class_name: "ShopsHouses"

  validates :latitude, presence: true, uniqueness: true
  validates :longitude, presence: true, uniqueness: true
end
