class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :player_id
      t.integer :game_id
      t.boolean :playing, default: true

      t.timestamps
    end
  end
end
