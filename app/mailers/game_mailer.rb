class GameMailer < ActionMailer::Base
  default from: 'Diana Jarosiewicz <jarosiewicz_diana@cat.com>'

  def reminder(game, player, message)
    @game = game
    @player = player
    @message = message

    date = @game.starts_at.strftime('%b %-d')

    mail(to: @player.email, subject: "Ultimate Frisbee: #{date}")
  end
end
