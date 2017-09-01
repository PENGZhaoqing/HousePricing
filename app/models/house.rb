require 'csv'
class House < ActiveRecord::Base
  has_many :buses_houses, class_name: "BusesHouses"
  has_many :buses, through: :buses_houses

  has_many :hospitals_houses, class_name: "HospitalsHouses"
  has_many :hospitals, through: :hospitals_houses

  has_many :schools_houses, class_name: "SchoolsHouses"
  has_many :schools, through: :schools_houses

  has_many :shops_houses, class_name: "ShopsHouses"
  has_many :shops, through: :shops_houses

  has_many :subways_houses, class_name: "SubwaysHouses"
  has_many :subways, through: :subways_houses

  has_many :works_houses, class_name: "WorksHouses"
  has_many :works, through: :works_houses

  def self.search(query)
    unless query.blank?
      # 若query为数字，则直接用build_time和area匹配
      if query.to_i.to_s==query
        House.where('build_time = :search OR area = :search', search: query)
      else
        House.where('community LIKE :search OR street LIKE :search OR floor LIKE :search OR room_shape LIKE :search', search: "%#{query}%")
      end
    else
      House.all
    end
  end

  def self.next_record(id)
    House.where('id > ?', id).first
  end

  def self.filter(params)

    unless params[:price].blank?
      min=(params[:price].to_f-1.5)*10000
      max=(params[:price].to_f+1.5)*10000
      houses=House.where('average_price > :min AND average_price < :max', min: min, max: max)
    end

    unless params[:area].blank?
      min=params[:area].to_i-20
      max=params[:area].to_i+20
      houses=House.where('area > :min AND area < :max', min: min, max: max) if houses.nil?
      houses=houses.where('area > :min AND area < :max', min: min, max: max)
    end

    unless params[:build_time].blank?
      houses=House.where('build_time = :search', search: params[:build_time]) if houses.nil?
      houses=houses.where('build_time = :search', search: params[:build_time])
    end

    unless params[:room_shape].blank?
      houses=House.where('room_shape LIKE :search', search: params[:room_shape]) if houses.nil?
      houses=houses.where('room_shape LIKE :search', search: params[:room_shape])
    end

    unless params[:street].blank?
      houses=House.where('street LIKE :search', search: "%#{params[:street]}%") if houses.nil?
      houses=houses.where('street LIKE :search', search: "%#{params[:street]}%")
    end

    if houses.nil? or houses.blank?
      houses=House.all
    end

    return houses
  end

  def self.to_csv
    attributes = %w{id community street area average_price build_time floor room_shape latitude longitude schools.length buses.length shops.length hospitals.length works.length subways.length}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      House.all.each do |house|
        csv << attributes.map { |attr| house.send(attr) }
      end
    end
  end


end
