module NotificationService
  def self.method_missing(method, *args)
    if GameMailer.respond_to?(method)
      game_id, player_id, user_id, body = *args
      GameMailer.send(method, game: Game.find(game_id), player: Player.find(player_id), sender: User.find(user_id), body: body).deliver
    else
      super
    end
  end
end
