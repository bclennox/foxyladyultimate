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
    h.tag.i class: "glyphicon #{icon_class}"
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

  def edit_link
    h.link_to h.edit_player_path(self) do
      h.tag.span('Edit', class: 'sr-only') +
        h.tag.i(class: 'edit-player glyphicon glyphicon-edit')
    end
  end

  def remove_link
    h.link_to h.player_path(self), method: :delete, data: { confirm: "Remove #{name}?" } do
      h.tag.span('Remove', class: 'sr-only') +
        h.tag.i(class: 'delete-player glyphicon glyphicon-remove')
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
