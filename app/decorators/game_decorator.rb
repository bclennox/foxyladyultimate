class GameDecorator < Draper::Decorator
  delegate_all
  include DateFormatter

  def self.date_format
    '%A, %B %-d, %Y at %l:%M%P'
  end

  def date
    object.starts_at.strftime(self.class.date_format)
  end

  def relative_date
    time_ago_in_words_with_modifier(object.starts_at)
  end

  def confirmed_player_names
    player_names(object.confirmed_players)
  end

  def declined_player_names
    player_names(object.declined_players)
  end

  def player_names(players)
    names = players.map(&:short_name)

    case names.size
      when 0    then object.upcoming? ? 'No one yet' : 'No one'
      when 1..2 then names.join(' and ')
      else           names[0..-2].join(', ') + ', and ' + names.last
    end
  end
end
