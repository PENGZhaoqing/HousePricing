require 'csv'
class House < ActiveRecord::Base
  has_and_belongs_to_many :buses
  has_and_belongs_to_many :hospitals
  has_and_belongs_to_many :schools
  has_and_belongs_to_many :shops
  has_and_belongs_to_many :subways
  has_and_belongs_to_many :works

  def self.search(query)
    unless query.blank?
      houses=House.where('community LIKE :search OR street LIKE :search OR floor LIKE :search OR room_shape LIKE :search', search: "%#{query}%")
      # houses=houses.where('build_time = ?', query).where('area = ?', query)
    else
      houses= House.all
    end

    return houses
  end

  def self.to_csv
    attributes = %w{id community street average_price build_time floor room_shape latitude longitude distance school_num bus_num shop_num hospital_num work_num subway_num}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      House.all.each do |house|
        csv << attributes.map{ |attr| house.send(attr) }
      end
    end
  end


end
