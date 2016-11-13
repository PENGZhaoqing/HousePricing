class HousesWorks < ActiveRecord::Migration
  def change
    create_table :houses_works do |t|
      t.belongs_to :work
      t.belongs_to :house
      t.integer :distance
      t.timestamps null: false
    end
  end
end
