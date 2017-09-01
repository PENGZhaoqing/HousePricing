class SchoolsHouses < ActiveRecord::Migration
  def change
    create_table :schools_houses do |t|
      t.belongs_to :school
      t.belongs_to :house
      t.integer  :distance
      t.timestamps null: false
    end
  end
end
