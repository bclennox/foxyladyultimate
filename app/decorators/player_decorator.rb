class PlayerDecorator < Draper::Decorator
  delegate_all
  include DateFormatter

  def attendance
    if games.empty?
      'Never played'
    else
      "Played #{last_played}, #{h.pluralize(games.size, 'game')} total"
    end
  end

  def icon
    h.content_tag(:i, nil, class: icon_class)
  end

private

  def icon_class
    source.worthy? ? 'worthy icon-star' : 'worthless icon-star-empty'
  end

  def games
    @games ||= source.played_games
  end

  def last_played
    time_ago_in_words_with_modifier(games.first.starts_at)
  end
end
