module PlayersHelper
  def player_attendance(player)
    games = player.played_games.all

    if games.empty?
      'Never played'
    else
      "Last played #{relative_date(games.first.starts_at)}, #{pluralize(games.size, 'game')} total"
    end
  end
end
