module GamesHelper
  def game_date(game)
    game.starts_at.strftime('%A, %B %d, %Y at %I:%M:%S %p')
  end
end
