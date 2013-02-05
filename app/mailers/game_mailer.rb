# encoding: utf-8
class GameMailer < ActionMailer::Base
  default from: 'Diana Jarosiewicz <jarosiewicz_diana@cat.com>'
  layout 'game_mailer'

  def reminder(game, player, message)
    perform(game, player, message, "Ultimate Frisbee on #{game_date(game)}")
  end

  def cancellation(game, player, message)
    perform(game, player, message, "Canceled: Ultimate Frisbee on #{game_date(game)}")
  end

  def reschedule(game, player, message)
    perform(game, player, message, "Rescheduled: Ultimate Frisbee on #{game_date(game)}")
  end

private

  def game_date(game)
    game.starts_at.strftime('%b %-d')
  end

  def responses
    [
      [ %{Count me in!}, %{Count me out} ],
      [ %{I'm in!}, %{I'm out} ],
      [ %{I'm ready to get sweaty!}, %{I have to wash my hair} ],
      [ %{I want to get skinny!}, %{I'd rather eat a milkshake} ],
      [ %{I wouldn't miss it!}, %{No thanks, I heard Troy’s coming} ],
      [ %{I'll be there with bells on!}, %{Maybe next week} ],
      [ %{I can't wait!}, %{I'm recovering from a volleyball tournament}],
    ]
  end

  def perform(game, player, message, subject)
    to = player.email

    @game = game
    @player = player
    @message = message
    @positive_response, @negative_response = responses.sample

    mail(to: to, subject: subject)
  end
end
