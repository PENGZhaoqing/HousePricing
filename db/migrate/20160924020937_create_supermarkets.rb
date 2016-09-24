class CreateSupermarkets < ActiveRecord::Migration
  def change
    create_table :supermarkets do |t|

      t.timestamps null: false
    end
  end
end
