class AddDeletedAtToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :deleted_at, :datetime
  end
end
