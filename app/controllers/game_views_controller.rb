require 'json'
class GameViewsController < ApplicationController

  def test
  end


  def ajax
    file = File.read('app/views/game_views/_housedata.json')
    list=[]
    file.gsub(/\{(.*?)\}/).each do |line|
      list<< JSON.parse(line)['location']
    end
    render json: list.as_json
  end

  def home

  end

end