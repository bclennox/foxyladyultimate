class GameMailerPreview < ActionMailer::Preview
  def reminder
    game = Game.first
    player = Player.find(2)
    sender = User.find(1)
    body = 'Would you like to play some ultimate frisbee?'

    GameMailer.reminder(game, player, sender, body)
  end
end
