class SubwaysHouses < ActiveRecord::Migration
  def change
    create_table :subways_houses do |t|
      t.belongs_to :subway
      t.belongs_to :house
      t.integer :distance
      t.timestamps null: false
    end
  end
end
