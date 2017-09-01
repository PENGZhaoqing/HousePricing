class HousesController < ApplicationController

  def index
    @houses=House.search(search_params).order('id').paginate(:page => params[:page], :per_page => 20)
  end

  def map
  end

  def filter_null
    @houses=House.where('houses.latitude' => nil, 'houses.longitude' => nil)
    @houses.each do |house|
      house.destroy
    end
    redirect_to houses_path, flash: {:success => '成功删除'}
  end

  def return_houses
    houses=House.filter(params)
    respond_to do |format|
      format.json { render :json => houses }
    end
  end

  # for scatter plot
  def return_nums_prices
    houses=House.limit(10)
    nums_prices=houses.map { |house| [house.buses.length,house.hospitals.length, house.shops.length,
                                      house.works.length, house.schools.length, house.subways.length,
                                      house.average_price] }
    respond_to do |format|
      format.json { render :json => nums_prices }
    end

  end

  def nearby
    house=House.find_by_id(params[:id])

    data=house.buses if params[:type]=='bus'
    data=house.works if params[:type]=='work'
    data=house.hospitals if params[:type]=='hospital'
    data=house.subways if params[:type]=='subway'
    data=house.shops if params[:type]=='shop'
    data=house.schools if params[:type]=='school'

    respond_to do |format|
      format.json { render :json => data }
    end
  end

  def show
    @house=House.find_by_id(params[:id])
  end

  def export
    @house=House.all
    respond_to do |format|
      format.xlsx { render "二手房数据_#{DateTime.now}", template: "houses/export.xlsx.axlsx" }
      format.csv { send_data @houses.to_csv, filename: "houses-#{Date.today}.csv" }
    end
  end

  private
  def search_params
    params[:query]
  end

end
