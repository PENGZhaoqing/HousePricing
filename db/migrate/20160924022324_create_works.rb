class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end

    add_index :works, :name
    add_index :works, :latitude
    add_index :works, :longitude
  end
end
