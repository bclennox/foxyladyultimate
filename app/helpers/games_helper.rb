module GamesHelper
  def game_date(game)
    game.starts_at.strftime('%A, %B %d, %Y at %I:%M:%S %p')
  end

  def game_players(game)
    players = game.players.map(&:short_name)

    case players.size
      when 0    then 'No one yet'
      when 1..2 then players.join(' and ')
      else           players[0..-2].join(', ') + ', and ' + players.last
    end
  end
end
