class AddAccessTokenToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :access_token, :string
  end
end
