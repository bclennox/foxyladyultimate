class Response < ActiveRecord::Base
  attr_accessible :game_id, :player_id, :playing
  belongs_to :player
  belongs_to :game
end
