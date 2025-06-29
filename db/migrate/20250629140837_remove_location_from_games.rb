class RemoveLocationFromGames < ActiveRecord::Migration[8.0]
  def up
    remove_column :games, :location
  end
end
