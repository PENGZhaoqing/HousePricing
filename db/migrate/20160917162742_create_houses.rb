class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.integer :area
      t.string :url
      t.integer :average_price
      t.string :floor
      t.string :build_time
      t.string :community
      t.string :location
      t.string :room_shape
      t.integer :price
      t.string :bus
      t.string :hospital
      t.string :school
      t.string :subway
      t.string :shopping
      t.string :supermarket

      t.timestamps null: false
    end
  end
end
