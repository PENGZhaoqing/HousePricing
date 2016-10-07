class HomeController < ApplicationController

  def index
  end

  def heatmapdata
    houses=House.where.not('houses.latitude' => nil).where.not('houses.longitude' => nil)
    respond_to do |format|
      format.json { render :json => houses }
    end
  end

  def heatmap

  end

  def map

  end

  @@house_id=0

  def ajax
    @@house_id= @@house_id+1
    house=House.find_by(id: @@house_id)

    while (!house.latitude.nil? and !house.longitude.nil?)
      @@house_id= @@house_id+1
      house=House.find_by(id: @@house_id)
    end

    respond_to do |format|
      format.json { render :json => house }
    end

  end

  def locate
    @house=House.find_by(id: params[:id])
    @house.latitude=params[:lat]
    @house.longitude=params[:lng]
    @house.save
    render json: params.as_json
  end

end