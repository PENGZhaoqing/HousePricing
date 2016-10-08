class HospitalsController < ApplicationController

  @@hospital=0

  def ajax
    @@hospital=@@hospital+1
    @house=House.find_by(id: @@hospital)
    respond_to do |format|
      format.json { render :json => @house }
    end
  end

  def index
    render 'shared/index', :locals => {:post_url => hospitals_path, :get_url => ajax_hospitals_path, :keyword => '医院'}
  end

  def create
    @house=House.find_by(id: params[:id])
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
end
