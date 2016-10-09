class HousesController < ApplicationController

  def index
    @houses=House.search(search_params).paginate(:page => params[:page], :per_page => 20)
  end

  def collect
    render 'houses/collect', :locals => {:post_url => houses_path, :get_url => get_each_houses_path}
  end

  def rollup
    House.all.each do |house|
      house.bus_num=house.buses.length unless house.buses.blank?
      house.work_num=house.works.length unless house.works.blank?
      house.school_num=house.schools.length unless house.schools.blank?
      house.subway_num=house.subways.length unless house.subways.blank?
      house.shop_num=house.shops.length unless house.shops.blank?
      house.hospital_num=house.hospitals.length unless house.hospitals.blank?
      house.save
    end
    redirect_to houses_path, flash: {:success => '整合完毕'}
  end

  def export
    @houses=House.limit(1000)
    render xlsx: "二手房数据_#{DateTime.now}", template: "houses/export.xlsx.axlsx"
  end

  @@house_id=0

  def get_each
    @@house_id= @@house_id+1
    house=House.find_by(id: @@house_id)

    while (!house.latitude.nil? and !house.longitude.nil? and !house.distance.nil?)
      @@house_id= @@house_id+1
      house=House.find_by(id: @@house_id)
    end

    respond_to do |format|
      format.json { render :json => house }
    end
  end

  def create
    @house=House.find_by(id: params[:id])
    @house.latitude=params[:lat]
    @house.longitude=params[:lng]
    @house.distance=params[:distance]
    @house.save
    render json: params.as_json
  end

  private
  def search_params
    params[:query]
  end

end
