class ShopsController < ApplicationController

  @@shop_id=0

  def ajax
    @@shop_id= @@shop_id+1

    @house=House.find_by(id: @@shop_id)
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
end
