class PlayerDecorator < Draper::Decorator
  delegate_all
  include DateFormatter

  def attendance
    if object.retired?
      'Retired'
    elsif games.empty?
      'Never played'
    else
      "Played #{last_played}, #{h.pluralize(games.size, 'game')} total"
    end
  end

  def icon
    h.content_tag(:i, nil, class: "glyphicon #{icon_class}")
  end

  def css_class
    if object.retired?
      'retired'
    elsif object.worthy?
      'worthy'
    else
      'worthless'
    end
  end

private

  def icon_class
    if object.retired?
      'glyphicon-heart-empty'
    elsif object.worthy?
      'glyphicon-star'
    else
      'glyphicon-star-empty'
    end
  end

  def games
    @games ||= object.played_games
  end

  def last_played
    time_ago_in_words_with_modifier(games.first.starts_at)
  end
end
