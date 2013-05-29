class PlayerRanker
  def self.games_played
    Player
      .joins(:games)
      .select('players.id, players.first_name, players.last_name, COUNT(responses.id) AS games_played')
      .where('responses.playing' => true)
      .where('games.canceled' => false)
      .group('players.id')
      .reorder('games_played DESC')
  end
end
