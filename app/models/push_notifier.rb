class PushNotifier
  include ActiveModel::Model

  attr_accessor :game, :player, :playing

  def notify
    PushSubscription.find_each do |subscription|
      WebPush.payload_send(
        message: payload.to_json,
        endpoint: subscription.endpoint,
        p256dh: subscription.p256dh,
        auth: subscription.auth,
        vapid: vapid
      )
    rescue WebPush::ExpiredSubscription
      subscription.destroy
    end
  end

  private

  def payload
    verb = playing ? "is playing" : "can't make it"
    date = game.starts_at.strftime('%A, %B %-d')

    {
      title: "Foxy Lady Ultimate",
      body: "#{player.short_name} #{verb} on #{date}.",
      url: "/games/#{game.id}"
    }
  end

  def vapid
    credentials = Rails.application.credentials.vapid

    {
      subject: credentials.subject,
      public_key: credentials.public_key,
      private_key: credentials.private_key
    }
  end
end
