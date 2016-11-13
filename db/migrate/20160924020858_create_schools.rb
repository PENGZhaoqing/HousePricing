class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end

    add_index :schools, :name
    add_index :schools, :latitude
    add_index :schools, :longitude
  end
end
