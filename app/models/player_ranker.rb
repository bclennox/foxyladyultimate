class PlayerRanker
  def self.games_played
    Player
      .active
      .joins(:games)
      .select('players.*, COUNT(responses.id) AS games_played')
      .where('responses.playing' => true)
      .where('games.canceled' => false)
      .group('players.id')
      .reorder('games_played DESC')
  end
end
