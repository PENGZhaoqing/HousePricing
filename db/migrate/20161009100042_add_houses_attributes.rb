class AddHousesAttributes < ActiveRecord::Migration
  def change

    add_column :houses, :bus_num, :integer
    add_column :houses, :school_num, :integer
    add_column :houses, :work_num, :integer
    add_column :houses, :subway_num, :integer
    add_column :houses, :shop_num, :integer
    add_column :houses, :hospital_num, :integer

  end
end
