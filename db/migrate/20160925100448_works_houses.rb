class WorksHouses < ActiveRecord::Migration
  def change
    create_table :works_houses do |t|
      t.belongs_to :work
      t.belongs_to :house
      t.integer :distance
      t.timestamps null: false
    end
  end
end
