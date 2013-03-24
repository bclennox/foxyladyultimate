class PlayerDecorator < Draper::Decorator
  delegate_all

  def attendance
    games = source.played_games.all
    icon = source.active? ? 'active icon-star' : 'inactive icon-star-empty'

    tip = if games.empty?
      'Never played'
    else
      "Last played #{h.relative_date(games.first.starts_at)}, #{h.pluralize(games.size, 'game')} total"
    end

    h.content_tag(:i, nil, class: icon, title: tip)
  end
end
