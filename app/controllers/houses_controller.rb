class HousesController < ApplicationController


  def index
    @houses=House.search(search_params).paginate(:page => params[:page], :per_page => 20)
  end

  def collect
  end

  def export
    @houses=House.search(search_params)
    render xlsx: "二手房数据_#{DateTime.now}", template: "houses/export.xlsx.axlsx"
  end


  @@house_id=0

  def get_each
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

  def update
    @house=House.find_by(id: params[:id])
    @house.latitude=params[:lat]
    @house.longitude=params[:lng]
    @house.save
    render json: params.as_json
  end

  private
  def search_params
    params[:query]
  end

end
