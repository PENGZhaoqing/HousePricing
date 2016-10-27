class HousesController < ApplicationController


  before_action :login, only: [:filter, :rollup, :export,:get_each]

  def index
    @houses=House.search(search_params).paginate(:page => params[:page], :per_page => 20)
  end

  def collect
    render 'houses/collect', :locals => {:post_url => houses_path, :get_url => get_each_houses_path}
  end

  def filter
    @houses=House.where('houses.latitude' => nil, 'houses.longitude' => nil)
    @houses.each do |house|
      house.destroy
    end
    redirect_to houses_path, flash: {:success => '成功删除'}
  end

  def rollup
    House.all.each do |house|
      unless house.latitude.nil? and house.longitude.nil?
        unless house.buses.blank?
          house.bus_num=house.buses.length
        else
          house.bus_num=0
        end

        unless house.works.blank?
          house.work_num=house.works.length
        else
          house.work_num=0
        end

        unless house.schools.blank?
          house.school_num=house.schools.length
        else
          house.school_num=0
        end

        unless house.subways.blank?
          house.subway_num=house.subways.length
        else
          house.subway_num=0
        end

        unless house.shops.blank?
          house.shop_num=house.shops.length
        else
          house.shop_num=0
        end

        unless house.hospitals.blank?
          house.hospital_num=house.hospitals.length
        else
          house.hospital_num=0
        end

        house.save
      end
    end
    redirect_to houses_path, flash: {:success => '整合完毕'}
  end

  def ajax
    house=House.find_by_id(params[:id])

    data=house.buses if params[:data]=='bus'
    data=house.works if params[:data]=='work'
    data=house.hospitals if params[:data]=='hospital'
    data=house.subways if params[:data]=='subway'
    data=house.shops if params[:data]=='shop'
    data=house.schools if params[:data]=='school'

    respond_to do |format|
      format.json { render :json => data }
    end
  end

  def show
    @house=House.find_by_id(params[:id])
  end

  def export
    @houses=House.where.not('houses.latitude' => nil).where.not('houses.longitude' => nil).where('houses.distance < 40000')
    respond_to do |format|
      format.xlsx { render "二手房数据_#{DateTime.now}", template: "houses/export.xlsx.axlsx" }
      format.csv { send_data @houses.to_csv, filename: "houses-#{Date.today}.csv" }
    end
  end

  @@house_id=0

  def get_each
    @@house_id= @@house_id+1
    house=House.find_by(id: @@house_id)

    while (house.nil? or !house.latitude.nil? or !house.longitude.nil? or !house.distance.nil?)
      @@house_id= @@house_id+1
      house=House.find_by(id: @@house_id)
      if (@@house_id>House.last.id)
        break
      end
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

  def login
    if current_user.nil?
      redirect_to root_path, flash: {:warning => "只有管理员能进行此操作喔"}
    end
  end

end
