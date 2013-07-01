class GameDecorator < Draper::Decorator
  delegate_all
  include DateFormatter

  def date
    source.starts_at.strftime('%A, %B %-d, %Y at %l:%M%P')
  end

  def relative_date
    time_ago_in_words_with_modifier(source.starts_at)
  end

  def confirmed_player_names
    player_names(source.confirmed_players)
  end

  def declined_player_names
    player_names(source.declined_players)
  end

  def player_names(players)
    names = players.map(&:short_name)

    case names.size
      when 0    then source.upcoming? ? 'No one yet' : 'No one'
      when 1..2 then names.join(' and ')
      else           names[0..-2].join(', ') + ', and ' + names.last
    end
  end
end
