class Bus < ActiveRecord::Base

  has_many :houses, through: :buses_houses
  has_many :buses_houses, class_name: "BusesHouses"

  def self.to_csv
    attributes = %w{id name distance latitude longitude}

    CSV.generate(headers: true) do |csv|
      csv << attributes
      Bus.all.each do |bus|
        csv << attributes.map { |attr| bus.send(attr) }
      end
    end
  end

end
