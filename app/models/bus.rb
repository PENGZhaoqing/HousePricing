class Bus < ActiveRecord::Base
  has_and_belongs_to_many :houses
  validates :latitude, presence: true, uniqueness: true
  validates :longitude, presence: true, uniqueness: true

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
