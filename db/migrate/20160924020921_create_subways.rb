class CreateSubways < ActiveRecord::Migration
  def change
    create_table :subways do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end

    add_index :subways, :name
    add_index :subways, :latitude
    add_index :subways, :longitude
  end
end
