class PlayerDecorator < ApplicationDecorator
  include DateFormatter

  def attendance
    if retired?
      'Retired'
    elsif games.empty?
      'Never played'
    else
      "Played #{last_played}<br>#{h.pluralize(games.size, 'game')} total".html_safe
    end
  end

  def attendance_icon
    icon(attendance_icon_class)
  end

  def css_class
    if retired?
      'retired'
    elsif worthy?
      'worthy'
    else
      'worthless'
    end
  end

  def edit_link
    h.link_to h.edit_player_path(self) do
      h.tag.span('Edit', class: 'sr-only') + icon('pencil-fill', classes: 'edit-player')
    end
  end

  def remove_link
    h.link_to h.player_path(self), method: :delete, data: { confirm: "Remove #{name}?" } do
      h.tag.span('Remove', class: 'sr-only') + icon('x-circle-fill', classes: 'remove-player')
    end
  end

  private

  def attendance_icon_class
    if retired?
      'heart-fill'
    elsif worthy?
      'star-fill'
    else
      'star'
    end
  end

  def games
    @games ||= played_games
  end

  def last_played
    time_ago_in_words_with_modifier(games.first.starts_at)
  end
end
