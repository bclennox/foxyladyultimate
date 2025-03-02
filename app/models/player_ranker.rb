class PlayerRanker
  def self.by_games_played(since: )
    Player
      .active
      .joins(:games)
      .select('players.*, COUNT(responses.id) AS games_played')
      .where('responses.playing' => true)
      .where('games.canceled' => false)
      .where('games.starts_at < NOW()')
      .where('games.starts_at > ?', since)
      .group('players.id')
      .reorder('games_played DESC')
  end
end
