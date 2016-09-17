require 'json'
class HomeController < ApplicationController


  def ajax
    file = File.read('app/views/home/housedata.json')
    list=[]
    file.gsub(/\{(.*?)\}/).each do |line|
      list<< JSON.parse(line)['location']
    end
    render json: list.as_json
  end

  def index

  end

end