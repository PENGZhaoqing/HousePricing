class BusesController < ApplicationController

  before_action :login, only: [:ajax, :export, :export_asso]
  @@bus_id=0

  def ajax
    @@bus_id= @@bus_id+1
    house=House.find_by(id: @@bus_id)
    # 避免重复抓取
    while not house.buses_houses.blank?
      @@bus_id= @@bus_id+1
      house=House.find_by(id: @@bus_id)
      break if @@bus_id>House.last.id
    end
    if @@bus_id> House.last.id
      redirect_to buses_path, flash: {:success => "抓取完毕"}
    else
      respond_to do |format|
        format.json { render :json => house }
      end
    end
  end

  def index
    render 'shared/index', :locals => {:post_url => buses_path, :get_url => ajax_buses_path, :keyword => '公交车站'}
  end

  def create
    @house=House.find_by(id: params[:id])
    @house.buses_houses.delete_all
    params[:info].split(',').each do |row|
      attr=row.split('/')
      bus=Bus.find_by(longitude: attr[1], latitude: attr[2])
      if bus.nil?
        bus=Bus.new(name: attr[0], longitude: attr[1], latitude: attr[2])
        bus.save
      end
      BusesHouses.create(bus_id: bus.id, house_id: @house.id, distance: attr[3])
    end
    render json: params.as_json
  end

  def export
    respond_to do |format|
      format.csv { send_data Bus.to_csv, filename: "buses-#{Date.today}.csv" }
    end
  end

  def export_asso
    respond_to do |format|
      format.csv { send_data BusesHouses.to_csv, filename: "buses_houses-#{Date.today}.csv" }
    end
  end

  private

  def login
    if current_user.nil?
      redirect_to root_path, flash: {:warning => "只有管理员能进行此操作喔"}
    end
  end


end
