class PushNotifier
  include ActiveModel::Model

  attr_accessor :game, :player, :playing

  def notify_rsvp
    verb = playing ? "is playing" : "can't make it"
    broadcast("#{player.short_name} #{verb} on #{date}.")
  end

  def notify_cancellation
    broadcast("Game canceled on #{date}.")
  end

  def notify_new_game
    broadcast("New game scheduled for #{date}.")
  end

  def notify_reschedule
    broadcast("Game back on for #{date}.")
  end

  def notify_update
    broadcast("Game on #{date} has been updated.")
  end

  private

  def broadcast(body)
    PushSubscription.find_each do |subscription|
      payload = {
        title: "Foxy Lady Ultimate",
        body: body,
        url: build_game_url(subscription.user),
        icon: icon_path
      }

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

  def date
    game.starts_at.strftime('%A, %B %-d')
  end

  def icon_path
    ActionController::Base.helpers.asset_path("icon.png")
  end

  def vapid
    credentials = Rails.application.credentials.vapid

    {
      subject: credentials.subject,
      public_key: credentials.public_key,
      private_key: credentials.private_key
    }
  end

  def build_game_url(user)
    token = user.player.access_token
    "/games/#{game.id}?access_token=#{token}"
  end
end
