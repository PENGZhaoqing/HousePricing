class HousesShops < ActiveRecord::Migration
  def change
    create_table :houses_shops do |t|
      t.belongs_to :shop
      t.belongs_to :house
      t.integer :distance
      t.timestamps null: false
    end
  end
end
