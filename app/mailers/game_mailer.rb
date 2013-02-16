# encoding: utf-8
class GameMailer < ActionMailer::Base
  layout 'game_mailer'

  def self.responses
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

  def reminder(game, player, sender, message)
    perform(game, player, sender, message, "Ultimate Frisbee on #{game_date(game)}")
  end

  def cancellation(game, player, sender, message)
    perform(game, player, sender, message, "Canceled: Ultimate Frisbee on #{game_date(game)}")
  end

  def reschedule(game, player, sender, message)
    perform(game, player, sender, message, "Rescheduled: Ultimate Frisbee on #{game_date(game)}")
  end

private

  def game_date(game)
    game.starts_at.strftime('%b %-d')
  end

  def perform(game, player, sender, message, subject)
    to = Rails.env.development? ? 'brandan@localhost' : player.email
    from = "#{sender.name} <#{sender.email}>"

    @game = game
    @player = player
    @message = message
    @positive_response, @negative_response = self.class.responses.sample

    mail(to: to, from: from, subject: subject)
  end
end
