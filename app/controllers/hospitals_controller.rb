class HospitalsController < ApplicationController

  before_action :login, only: [:ajax]

  @@hospital=0

  def ajax
    @@hospital=@@hospital+1
    house=House.find_by(id: @@hospital)
    while (house.nil? or house.hospitals.count<=50)
      @@hospital= @@hospital+1
      house=House.find_by(id: @@hospital)
      if @@hospital>House.last.id
        break
      end
    end
    respond_to do |format|
      format.json { render :json => house }
    end
  end

  def index
    render 'shared/index', :locals => {:post_url => hospitals_path, :get_url => ajax_hospitals_path, :keyword => '医院'}
  end

  def create
    @house=House.find_by(id: params[:id])
    @house.hospitals.delete_all
    params[:info].split(',').each do |row|
      attr=row.split('/')
      hospital=Hospital.new(name: attr[0], longitude: attr[1], latitude: attr[2], distance: attr[3])
      if hospital.valid?
        hospital.save!
        @house.hospitals<<hospital
      else
        exsited_hospital=Hospital.find_by(longitude: attr[1], latitude: attr[2])
        unless exsited_hospital.nil?
          @house.hospitals<<exsited_hospital
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
