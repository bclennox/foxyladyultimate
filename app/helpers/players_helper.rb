module PlayersHelper
  def player_attendance(player)
    games = player.played_games.all
    icon = player.active? ? 'active icon-star' : 'inactive icon-star-empty'

    tip = if games.empty?
      'Never played'
    else
      "Last played #{relative_date(games.first.starts_at)}, #{pluralize(games.size, 'game')} total"
    end

    content_tag(:i, nil, class: icon, title: tip)
  end
end
