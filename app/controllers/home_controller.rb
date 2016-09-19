require 'json'
class HomeController < ApplicationController

  def ajax
    @house = House.order(id: :desc).limit(1)
    respond_to do |format|
      format.json { render :json => @house }
    end
  end

  def index

  end

end