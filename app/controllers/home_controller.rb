require 'json'
class HomeController < ApplicationController

  def ajax
    @house=House.all
    respond_to do |format|
      format.json { render :json => @house }
    end
  end

  def index

  end

end