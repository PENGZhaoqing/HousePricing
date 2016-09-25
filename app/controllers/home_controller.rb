require 'json'
class HomeController < ApplicationController

  @@id=0

  def ajax
    # @house = House.order(id: :desc).limit(1)
    @@id=@@id+1
    @house=House.find_by(id: @@id)
    respond_to do |format|
      format.json { render :json => @house }
    end
  end

  def index
  end

  def collect
  end

  def bus
    @house=House.find_by(id: params[:id])
    params[:info].split(',').each do |row|
      attr=row.split('/')
      bus=Bus.new(name: attr[0], longitude: attr[1], latitude: attr[2], distance: attr[3])
      if bus.valid?
        bus.save!
        @house.buses<<bus
      end
    end
    render json: params.as_json
  end

  def school
    @house=House.find_by(id: @@id)
    render json: params.as_json
  end

  def hospital
    @house=House.find_by(id: @@id)
    render json: params.as_json
  end

  def subway
    @house=House.find_by(id: @@id)
    render json: params.as_json
  end

  def shopping
    @house=House.find_by(id: @@id)
    render json: params.as_json
  end

  def work
    @house=House.find_by(id: @@id)
    render json: params.as_json
  end

end