require 'json'
class HomeController < ApplicationController


  def ajax
    @house=House.first
    render json: @house.as_json
  end

  def index

  end

end