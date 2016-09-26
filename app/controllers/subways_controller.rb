class SubwaysController < ApplicationController

  @@subway_id=0

  def ajax
    @@subway_id=@@subway_id+1
    @house=House.find_by(id: @@subway_id)
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
end
