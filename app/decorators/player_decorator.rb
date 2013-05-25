class PlayerDecorator < Draper::Decorator
  delegate_all
  include DateFormatter

  def attendance
    h.content_tag(:i, nil, class: icon, title: tip)
  end

private

  def icon
    source.active? ? 'active icon-star' : 'inactive icon-star-empty'
  end

  def games
    @games ||= source.played_games.all
  end

  def tip
    if games.empty?
      'Never played'
    else
      "Last played #{last_played}, #{h.pluralize(games.size, 'game')} total"
    end
  end

  def last_played
    time_ago_in_words_with_modifier(games.first.starts_at)
  end
end
