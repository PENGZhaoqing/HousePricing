class HospitalsHouses < ActiveRecord::Migration
  def change
    create_table :hospitals_houses do |t|
      t.belongs_to :hospital
      t.belongs_to :house
      t.belongs_to :distance
      t.timestamps null: false
    end
  end
end
