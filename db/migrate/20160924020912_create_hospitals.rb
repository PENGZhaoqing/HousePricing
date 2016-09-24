class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|

      t.timestamps null: false
    end
  end
end
