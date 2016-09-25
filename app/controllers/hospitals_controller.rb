class HospitalsController < ApplicationController

  def ajax
    if !session[:hospital_id].nil?
      session[:hospital_id]=session[:hospital_id]+1
    else
      session[:hospital_id]=1
    end
    @house=House.find_by(id: session[:hospital_id])
    respond_to do |format|
      format.json { render :json => @house }
    end
  end

  def index
  end

  def create
    @house=House.find_by(id: params[:id])
    params[:info].split(',').each do |row|
      attr=row.split('/')
      bus=Bus.new(name: attr[0], longitude: attr[1], latitude: attr[2], distance: attr[3])
      if bus.valid?
        bus.save!
        @house.hospitals<<bus
      end
    end
    render json: params.as_json
  end
end
