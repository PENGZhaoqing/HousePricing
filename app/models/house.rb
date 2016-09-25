class House < ActiveRecord::Base
  has_and_belongs_to_many :buses
end
