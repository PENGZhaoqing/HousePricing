class WorksController < ApplicationController
  @@work_id=0

  def ajax
    @@work_id=@@work_id+1
    @house=House.find_by(id: @@work_id)
    respond_to do |format|
      format.json { render :json => @house }
    end
  end

  def index
    render 'shared/index', :locals => {:post_url => works_path, :get_url => ajax_works_path, :keyword => '写字楼'}
  end

  def create
    @house=House.find_by(id: params[:id])
    params[:info].split(',').each do |row|
      attr=row.split('/')
      work=Work.new(name: attr[0], longitude: attr[1], latitude: attr[2], distance: attr[3])
      if work.valid?
        work.save!
        @house.works<<work
      else
        exsited_work=Work.find_by(longitude: attr[1], latitude: attr[2])
        unless exsited_work.nil?
          @house.works<<exsited_work
        end
      end
    end
    render json: params.as_json
  end
end
