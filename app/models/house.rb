require 'csv'
class House < ActiveRecord::Base
  has_many :buses, through: :buses_houses
  has_many :buses_houses, class_name: "BusesHouses"

  has_and_belongs_to_many :hospitals
  has_and_belongs_to_many :schools
  has_and_belongs_to_many :shops
  has_and_belongs_to_many :subways
  has_and_belongs_to_many :works

  def self.search(query)
    unless query.blank?
      if query.to_i.to_s==query
        houses=House.where('build_time = :search OR area = :search', search: query)
      else
        houses=House.where('community LIKE :search OR street LIKE :search OR floor LIKE :search OR room_shape LIKE :search', search: "%#{query}%")
      end
    else
      houses= House.all
    end

    return houses
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

    unless params[:distance].blank?
      min=(params[:distance].to_f-1)*1000
      max=(params[:distance].to_i+1)*1000
      houses=House.where('distance > :min AND distance < :max', min: min, max: max) if houses.nil?
      houses=houses.where('distance > :min AND distance < :max', min: min, max: max)
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
    attributes = %w{id community street area average_price build_time floor room_shape latitude longitude distance school_num bus_num shop_num hospital_num work_num subway_num}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      House.all.each do |house|
        csv << attributes.map { |attr| house.send(attr) }
      end
    end
  end


end
