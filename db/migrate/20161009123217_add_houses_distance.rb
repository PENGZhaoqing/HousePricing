class AddHousesDistance < ActiveRecord::Migration
  def change
    add_column :houses, :distance, :float
  end
end
