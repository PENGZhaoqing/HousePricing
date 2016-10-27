class SchoolsController < ApplicationController

  before_action :login, only: [:ajax]

  @@school_id=0

  def ajax
    @@school_id=@@school_id+1
    house=House.find_by(id: @@school_id)
    while (house.nil? or house.schools.count<=50)
      @@school_id= @@school_id+1
      house=House.find_by(id: @@school_id)
      if @@school_id>House.last.id
        break
      end
    end
    respond_to do |format|
      format.json { render :json => house }
    end
  end

  def index
    render 'shared/index', :locals => {:post_url => schools_path, :get_url => ajax_schools_path, :keyword => '学校'}
  end

  def create
    @house=House.find_by(id: params[:id])
    @house.schools.delete_all
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

  private
  def login
    if current_user.nil?
      redirect_to root_path, flash: {:warning => "只有管理员能进行此操作喔"}
    end
  end

end
