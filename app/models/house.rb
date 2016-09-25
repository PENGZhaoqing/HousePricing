class House < ActiveRecord::Base
  has_and_belongs_to_many :buses
  has_and_belongs_to_many :hospitals
  has_and_belongs_to_many :schools
  has_and_belongs_to_many :shops
  has_and_belongs_to_many :subways
  has_and_belongs_to_many :works
end
