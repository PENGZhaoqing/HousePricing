class ShopsHouses < ActiveRecord::Migration
  def change
    create_table :shops_houses do |t|
      t.belongs_to :shop
      t.belongs_to :house
      t.integer :distance
      t.timestamps null: false
    end
  end
end
