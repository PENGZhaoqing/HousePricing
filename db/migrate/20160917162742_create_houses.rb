class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|

      t.integer :area
      t.string :url
      t.integer :average_price
      t.string :floor
      t.string :build_time
      t.string :community
      t.string :room_shape
      t.float :latitude
      t.float :longitude
      t.string :street
      t.integer :work_num
      t.integer :hospital_num
      t.integer :subway_num
      t.integer :shop_num
      t.integer :bus_num
      t.integer :school_num
      t.float :distance

      t.timestamps null: false
    end
  end
end
