class GameMailer < ActionMailer::Base
  default from: 'jarosiewicz_diana@cat.com'

  def reminder(game, message)
    @game = game
    @message = message
    @player = Player.find(1)

    date = @game.starts_at.strftime('%b %d')

    mail(to: 'brandan@localhost', subject: "Ultimate Frisbee: #{date}")
  end
end
