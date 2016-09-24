require 'json'
class HomeController < ApplicationController

  @@id=1

  def ajax
    # @house = House.order(id: :desc).limit(1)
    @house=House.find_by(id: @@id)
    @@id=@@id+1
    respond_to do |format|
      format.json { render :json => @house }
    end
  end

  def index
  end

  def collect
  end

  def bus
    @house=House.find_by(id: @@id)
    @house.bus=params[:info]
    @house.save
    render json: params.as_json
  end

  def school
    @house=House.find_by(id: @@id)
    @house.bus=params[:info]
    render json: params.as_json
  end

  def hospital
    @house=House.find_by(id: @@id)
    @house.hospital=params[:info]
    render json: params.as_json
  end

  def subway
    @house=House.find_by(id: @@id)
    @house.subway=params[:info]
    render json: params.as_json
  end

  def shopping
    @house=House.find_by(id: @@id)
    @house.shopping=params[:info]
    render json: params.as_json
  end

  def supermarket
    @house=House.find_by(id: @@id)
    @house.supermarket=params[:info]
    render json: params.as_json
  end

end