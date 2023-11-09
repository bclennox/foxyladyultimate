class CreateQuips < ActiveRecord::Migration[7.0]
  def change
    create_table :quips do |t|
      t.text :confirmation, null: false
      t.text :rejection, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
