module HousesHelper

  def average_distance(items)
    return 0 if items.length == 0
    items.map(&:distance).sum/items.length
  end

  def insert(house, params, obj, asso_obj, asso_type)
    params[:nearby_info].split(',').each do |row|
      attr=row.split('/')
      bus=obj.find_by(longitude: attr[1], latitude: attr[2])
      if bus.nil?
        bus=obj.new(name: attr[0], longitude: attr[1], latitude: attr[2])
        bus.save
      end
      asso_obj.create("#{asso_type}_id": bus.id, house_id: house.id, distance: attr[3])
    end
  end

end
