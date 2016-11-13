class HousesSubways < ActiveRecord::Migration
  def change
    create_table :houses_subways do |t|
      t.belongs_to :subway
      t.belongs_to :house
      t.integer :distance
      t.timestamps null: false
    end
  end
end
