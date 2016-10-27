class SubwaysController < ApplicationController

  before_action :login, only: [:ajax]

  @@subway_id=0

  def ajax
    @@subway_id=@@subway_id+1
    house=House.find_by(id: @@subway_id)
    while (house.nil? or house.subways.count<=50)
      @@subway_id= @@subway_id+1
      house=House.find_by(id: @@subway_id)
      if @@subway_id>House.last.id
        break
      end
    end
    respond_to do |format|
      format.json { render :json => house }
    end
  end

  def index
    render 'shared/index', :locals => {:post_url => subways_path, :get_url => ajax_subways_path, :keyword => '地铁'}
  end

  def create
    @house=House.find_by(id: params[:id])
    @house.subways.delete_all
    params[:info].split(',').each do |row|
      attr=row.split('/')
      subway=Subway.new(name: attr[0], longitude: attr[1], latitude: attr[2], distance: attr[3])
      if subway.valid?
        subway.save!
        @house.subways<<subway
      else
        exsited_subway=Subway.find_by(longitude: attr[1], latitude: attr[2])
        unless exsited_subway.nil?
          @house.subways<<exsited_subway
        end
      end
    end
    render json: params.as_json
  end

  private

  def login
    if current_user.nil?
      redirect_to root_path, flash: {:warning => "只有管理员能进行此操作喔"}
    end
  end

end
