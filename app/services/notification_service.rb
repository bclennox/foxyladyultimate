module NotificationService
  def self.method_missing(method, *args)
    if GameMailer.respond_to?(method)
      game_id, player_id, user_id, message = *args
      GameMailer.send(method, Game.find(game_id), Player.find(player_id), User.find(user_id), message).deliver
    else
      super
    end
  end
end
