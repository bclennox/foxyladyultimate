module PlayersHelper
  def player_attendance(player)
    games = player.played_games.all

    if games.empty?
      'Never played'
    else
      "Last played #{time_ago_in_words(games.first.starts_at)} ago, #{pluralize(games.size, 'game')} total"
    end
  end
end
