module GamesHelper
  DATE_FORMAT = '%A, %B %-d, %Y at %l:%M%P'

  def game_date(game)
    game.starts_at.strftime(DATE_FORMAT)
  end

  def game_players(game, filter = nil)
    method = filter.nil? ? :players : filter ? :confirmed_players : :declined_players
    players = game.send(method).map(&:short_name)

    case players.size
      when 0    then game.upcoming? ? 'No one yet' : 'No one'
      when 1..2 then players.join(' and ')
      else           players[0..-2].join(', ') + ', and ' + players.last
    end
  end
end
