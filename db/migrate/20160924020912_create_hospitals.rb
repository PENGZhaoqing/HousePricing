class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end

    add_index :hospitals, :name
    add_index :hospitals, :latitude
    add_index :hospitals, :longitude
  end
end
