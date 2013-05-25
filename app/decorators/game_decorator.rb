class GameDecorator < Draper::Decorator
  delegate_all
  include DateFormatter

  def date
    source.starts_at.strftime('%A, %B %-d, %Y at %l:%M%P')
  end

  def relative_date
    time_ago_in_words_with_modifier(source.starts_at)
  end

  def players(filter = nil)
    method = filter.nil? ? :players : filter ? :confirmed_players : :declined_players
    players = source.send(method).map(&:short_name)

    case players.size
      when 0    then source.upcoming? ? 'No one yet' : 'No one'
      when 1..2 then players.join(' and ')
      else           players[0..-2].join(', ') + ', and ' + players.last
    end
  end
end
