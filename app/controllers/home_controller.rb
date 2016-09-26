class HomeController < ApplicationController

  def index

  end

  def ajax
    @house=[]
    @house<<House.find_by(id: 7)
    respond_to do |format|
      format.json { render :json => @house }
    end
  end

end