class AddRetiredToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :retired, :boolean, null: false, default: false
  end
end
