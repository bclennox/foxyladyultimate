class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
