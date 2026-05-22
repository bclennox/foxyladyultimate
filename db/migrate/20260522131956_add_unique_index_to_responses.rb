class AddUniqueIndexToResponses < ActiveRecord::Migration[8.0]
  def change
    add_index :responses, [:game_id, :player_id], unique: true
  end
end
