class GameMailerPreview < ActionMailer::Preview
  def reminder
    game = Game.last
    player = Player.find(2)
    sender = User.find(1)
    body = 'Would you like to play some ultimate frisbee?'

    GameMailer.reminder(game, player, sender, body)
  end

  def cancellation
    game = Game.last
    player = Player.find(2)
    sender = User.find(1)
    body = 'Not enough people :-('

    GameMailer.cancellation(game, player, sender, body)
  end

  def reschedule
    game = Game.last
    player = Player.find(2)
    sender = User.find(1)
    body = 'Back on!'

    GameMailer.reschedule(game, player, sender, body)
  end
end
