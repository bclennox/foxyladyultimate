class GameMailer < ApplicationMailer
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

  %w{reminder cancellation reschedule}.each do |message_type|
    define_method(message_type) do |game, player, sender, body|
      send_message self.class.const_get("#{message_type.classify}Message").new(game, player, sender, body)
    end
  end

private

  Message = Struct.new(:game, :player, :sender, :body) do
    def to
      player.email
    end

    def from
      "#{sender.name} <#{sender.email}>"
    end

  private

    def game_date
      game.starts_at.strftime('%b %-d')
    end
  end

  class ReminderMessage < Message
    def subject() "Ultimate Frisbee on #{game_date}" end
  end

  class CancellationMessage < Message
    def subject() "Canceled: Ultimate Frisbee on #{game_date}" end
  end

  class RescheduleMessage < Message
    def subject() "Rescheduled: Ultimate Frisbee on #{game_date}" end
  end

  def send_message(message)
    to = Rails.env.development? ? 'brandan@localhost' : message.to
    from = message.from
    subject = message.subject

    @game = message.game.decorate
    @player = message.player
    @body = message.body
    @positive_response, @negative_response = self.class.responses.sample

    attachments['ultimate.ics'] = Event.new(game: @game, view_context: view_context).to_ical

    mail(to: to, from: from, subject: subject)
  end
end
