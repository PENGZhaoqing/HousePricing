class BusesController < ApplicationController

  @@bus_id=0

  def ajax
    @@bus_id= @@bus_id+1
    house=House.find_by(id: @@bus_id)
    while (house.nil? or house.buses.count<=50)
      @@bus_id= @@bus_id+1
      house=House.find_by(id: @@bus_id)
      if @@bus_id>House.last.id
        break
      end
    end
    respond_to do |format|
      format.json { render :json => house }
    end
  end

  def index
    render 'shared/index', :locals => {:post_url => buses_path, :get_url => ajax_buses_path, :keyword => '公交车站'}
  end

  def create
    @house=House.find_by(id: params[:id])
    @house.buses.delete_all
    params[:info].split(',').each do |row|
      attr=row.split('/')
      bus=Bus.new(name: attr[0], longitude: attr[1], latitude: attr[2], distance: attr[3])
      if bus.valid?
        bus.save!
        @house.buses<<bus
      else
        exsited_bus=Bus.find_by(longitude: attr[1], latitude: attr[2])
        unless exsited_bus.nil?
          @house.buses<<exsited_bus
        end
      end
    end
    render json: params.as_json
  end


end
