class ShopsController < ApplicationController


  before_action :login, only: [:ajax]


  @@shop_id=0

  def ajax
    @@shop_id= @@shop_id+1
    house=House.find_by(id: @@shop_id)
    while (house.nil? or house.shops.count<=50)
      @@shop_id= @@shop_id+1
      house=House.find_by(id: @@shop_id)
      if @@shop_id>House.last.id
        break
      end
    end
    respond_to do |format|
      format.json { render :json => house }
    end
  end

  def index
    render 'shared/index', :locals => {:post_url => shops_url, :get_url => ajax_shops_path, :keyword => '商场'}
  end

  def create
    @house=House.find_by(id: params[:id])
    @house.shops.delete_all
    params[:info].split(',').each do |row|
      attr=row.split('/')
      shop=Shop.new(name: attr[0], longitude: attr[1], latitude: attr[2], distance: attr[3])
      if shop.valid?
        shop.save!
        @house.shops<<shop
      else
        exsited_shop=Shop.find_by(longitude: attr[1], latitude: attr[2])
        unless exsited_shop.nil?
          @house.shops<<exsited_shop
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
