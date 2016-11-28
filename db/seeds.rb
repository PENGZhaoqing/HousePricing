# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

file = File.read('db/housedata.json')

file.gsub(/\{(.*?)\}/).each do |line|
  hash=JSON.parse(line)
  house=House.new
  house.area=hash['area'][0].scan(/[0-9]/).join.to_i
  house.url=hash['url'][0]
  house.average_price=hash['average_price'][0].scan(/[0-9]/).join.to_i
  house.floor=hash['floor'][0]
  house.build_time=hash['build_time'][0].scan(/[0-9]/).join
  house.community=hash['location'][0].delete(' ').scan(/\n(.*?)\n/).join.gsub("\u00A0", "")
  house.street=hash['location'][0].delete(' ').scan(/\[(.*?)\]/).join
  house.room_shape=hash['room_shape'][0]
  house.save
end

User.create(
    name: "彭兆卿",
    email: "admin@housepricing.com",
    password: "password",
    password_confirmation: "password",
    admin: true
)