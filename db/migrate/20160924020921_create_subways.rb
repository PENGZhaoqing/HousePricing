class CreateSubways < ActiveRecord::Migration
  def change
    create_table :subways do |t|

      t.timestamps null: false
    end
  end
end
