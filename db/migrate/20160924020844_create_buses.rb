class CreateBuses < ActiveRecord::Migration
  def change
    create_table :buses do |t|
      t.string :name
      t.integer :distance
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end

    add_index :buses, :name
    add_index :buses, :latitude
    add_index :buses, :longitude

  end
end
