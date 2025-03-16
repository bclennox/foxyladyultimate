class PlayerDecorator < ApplicationDecorator
  include DateFormatter

  def attendance
    if retired?
      'Retired'
    elsif confirmed_games.empty?
      'Never played'
    else
      "Played #{last_played}<br>#{h.pluralize(confirmed_games.size, 'game')} total".html_safe
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
      h.tag.span('Edit', class: 'visually-hidden') + icon(:pencil_fill)
    end
  end

  def remove_link
    h.link_to h.player_path(self), data: { turbo_method: :delete, turbo_confirm: "Remove #{name}?" } do
      h.tag.span('Remove', class: 'visually-hidden') + icon(:x_circle_fill)
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

  def last_played
    time_ago_in_words_with_modifier(confirmed_games.last.starts_at)
  end
end
