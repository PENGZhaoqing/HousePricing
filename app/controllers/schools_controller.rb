class SchoolsController < ApplicationController
  @@school_id=0

  def ajax
    @@school_id=@@school_id+1
    @house=House.find_by(id: @@school_id)
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
      school=School.new(name: attr[0], longitude: attr[1], latitude: attr[2], distance: attr[3])
      if school.valid?
        school.save!
        @house.schools<<school
      else
        exsited_school=School.find_by(longitude: attr[1], latitude: attr[2])
        unless exsited_school.nil?
          @house.schools<<exsited_school
        end
      end
    end
    render json: params.as_json
  end
end
