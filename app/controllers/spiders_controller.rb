class SpidersController < ApplicationController

  # TODO
  # 增加权限控制，只有管理员才能调用return_next和create
  # END

  @@house_id=0

  def return_next
    # 查询下一个房屋信息
    house=House.next_record(@@house_id)
    @@house_id=house.id

    # 避免重复抓取，跳过已经有相关信息的
    while not house.buses_houses.nil? and not house.buses_houses.blank?
      house=House.next_record(@@house_id)
      @@house_id=house.id
      break if house == House.last
    end

    # TODO
    # 避免重复抓取，现在只能靠bus信息进行判断，希望更全面的信息判断
    # END

    if house == House.last
      redirect_to buses_path, flash: {:success => "抓取完毕"}
    else
      respond_to do |format|
        format.json { render :json => house }
      end
    end
  end

  def index
  end

  def create
    house=House.find_by(id: params[:id])
    house.latitude=params[:lat]
    house.longitude=params[:lng]
    house.save

    insert(house, params, Bus, BusesHouses, 'bus') if params[:nearby_type] == 'bus'
    insert(house, params, Hospital, HospitalsHouses, 'hospital') if params[:nearby_type] == 'hospital'
    insert(house, params, Work, WorksHouses, 'work') if params[:nearby_type] == 'work'
    insert(house, params, School, SchoolsHouses, 'school') if params[:nearby_type] == 'school'
    insert(house, params, Subway, SubwaysHouses, 'subway') if params[:nearby_type] == 'subway'
    insert(house, params, Bus, ShopsHouses, 'shop') if params[:nearby_type] == 'shop'

    render json: params.as_json
  end


  # TODO
  # bus数据的导出，需要自己写前端
  # END
  def export_bus
    respond_to do |format|
      format.csv { send_data Bus.to_csv, filename: "buses-#{Date.today}.csv" }
    end
  end

  def export_bus_house
    respond_to do |format|
      format.csv { send_data BusesHouses.to_csv, filename: "buses_houses-#{Date.today}.csv" }
    end
  end

end
