module NotificationService
  def self.method_missing(method, game_id, player_id, message, *args)
    if GameMailer.respond_to?(method)
      GameMailer.send(method, Game.find(game_id), Player.find(player_id), message).deliver
    else
      super
    end
  end
end
