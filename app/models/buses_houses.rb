require 'csv'
class BusesHouses < ActiveRecord::Base

  belongs_to :house
  belongs_to :bus

end
