module NotificationService
  def self.reminder(game_id, player_id, message)
    GameMailer.reminder(Game.find(game_id), Player.find(player_id), message).deliver
  end
end
