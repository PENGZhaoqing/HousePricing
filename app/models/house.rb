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


end
