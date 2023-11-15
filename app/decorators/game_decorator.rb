class GameDecorator < ApplicationDecorator
  include DateFormatter

  def self.date_format
    '%A, %B %-d, %Y at %-l:%M%P'
  end

  def date
    starts_at.strftime(self.class.date_format)
  end

  def relative_date
    time_ago_in_words_with_modifier(starts_at)
  end

  def confirmed_player_names
    player_names(confirmed_players)
  end

  def declined_player_names
    player_names(declined_players)
  end

  def player_names(players)
    names = players.map(&:short_name)

    if names.empty?
      upcoming? ? 'No one yet' : 'No one'
    else
      names.to_sentence
    end
  end

  def calendar_link
    h.link_to h.game_path(game, format: 'ics') do
      icon('calendar-plus', classes: 'me-2') + 'Add it to your calendar'
    end
  end
end
