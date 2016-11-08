class HomeController < ApplicationController

  def index

  end

  def scatter

  end

  def bar

  end

  def heatmap

  end

  def tableau

  end

  def get_collection
    # houses=House.where.not('houses.latitude' => nil).where.not('houses.longitude' => nil).where('houses.distance < 80000')

    houses=House.filter(params)

    respond_to do |format|
      format.json { render :json => houses }
    end
  end

end