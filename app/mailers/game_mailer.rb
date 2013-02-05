class GameMailer < ActionMailer::Base
  default from: 'Diana Jarosiewicz <jarosiewicz_diana@cat.com>'
  layout 'game_mailer'

  def reminder(game, player, message)
    @game = game
    @player = player
    @message = message

    mail(to: @player.email, subject: "Ultimate Frisbee on #{game_date(@game)}")
  end

  def cancellation(game, player, message)
    @game = game
    @player = player
    @message = message

    mail(to: @player.email, subject: "Canceled: Ultimate Frisbee on #{game_date(@game)}")
  end

  def reschedule(game, player, message)
    @game = game
    @player = player
    @message = message

    mail(to: @player.email, subject: "Rescheduled: Ultimate Frisbee on #{game_date(@game)}")
  end

private

  def game_date(game)
    game.starts_at.strftime('%b %-d')
  end
end
