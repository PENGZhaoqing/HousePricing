class BusesHouses < ActiveRecord::Migration
  def change
    create_table :buses_houses do |t|
      t.belongs_to :bus
      t.belongs_to :house
      t.integer :distance
      t.timestamps null: false
    end
  end
end
