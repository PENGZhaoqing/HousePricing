class Hospital < ActiveRecord::Base
  has_and_belongs_to_many :houses
  validates :latitude, presence: true, uniqueness: true
  validates :longitude, presence: true, uniqueness: true
end
