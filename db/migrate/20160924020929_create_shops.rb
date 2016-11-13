class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end

    add_index :shops, :name
    add_index :shops, :latitude
    add_index :shops, :longitude
  end
end
