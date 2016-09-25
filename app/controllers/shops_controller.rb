class ShopsController < ApplicationController
  def ajax
    if !session[:bus_id].nil?
      session[:bus_id]=session[:bus_id]+1
    else
      session[:bus_id]=1
    end
    @house=House.find_by(id: session[:bus_id])
    respond_to do |format|
      format.json { render :json => @house }
    end
  end

  def index
  end

  def create
    @house=House.find_by(id: params[:id])
    params[:info].split(',').each do |row|
      attr=row.split('/')
      bus=Bus.new(name: attr[0], longitude: attr[1], latitude: attr[2], distance: attr[3])
      if bus.valid?
        bus.save!
        @house.buses<<bus
      end
    end
    render json: params.as_json
  end
end
