class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :location, default: 'Dillard Drive Elementary'
      t.datetime :starts_at
      t.boolean :canceled

      t.timestamps
    end
  end
end
