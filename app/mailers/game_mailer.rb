class GameMailer < ApplicationMailer
  layout 'game_mailer'

  %w{reminder cancellation reschedule}.each do |message_type|
    define_method(message_type) do |game, player, sender, body|
      send_message self.class.const_get("#{message_type.classify}Message").new(game, player, sender, body)
    end
  end

  private

  Message = Struct.new(:game, :player, :sender, :body) do
    def to
      Rails.env.development? ? 'brandan@localhost' : player.email
    end

    def from
      "#{sender.name} <#{sender.smtp_username}>"
    end

    def reply_to
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
    to = message.to
    from = message.from
    subject = message.subject
    reply_to = message.reply_to
    quip = RandomQuip.call

    @game = message.game.decorate
    @location = @game.location
    @player = message.player
    @body = message.body
    @confirmation = quip.confirmation
    @rejection = quip.rejection

    attachments['ultimate.ics'] = Event.new(game: @game, view_context: view_context).to_ical

    headers['List-Unsubscribe'] = "<mailto:bclennox@gmail.com?subject=Unsubscribe+#{@player.access_token}> <#{new_removal_url(access_token: @player.access_token)}>"

    delivery_method_options = {
      user_name: message.sender.smtp_username,
      password: message.sender.smtp_password
    }

    mail(to: , from: , subject: , reply_to: , delivery_method_options: )
  end
end
