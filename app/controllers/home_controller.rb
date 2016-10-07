class HomeController < ApplicationController

  def index
  end

  def get_collection
    houses=House.where.not('houses.latitude' => nil).where.not('houses.longitude' => nil)
    respond_to do |format|
      format.json { render :json => houses }
    end
  end


end