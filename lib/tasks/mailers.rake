namespace :mailers do
  task setup: :environment do
    @game = Game.first
    @player = Player.find(1)
    @sender = User.find(1)
    @body = 'Example body'
  end

  task reminder: :setup do
    GameMailer.reminder(@game, @player, @sender, @body).deliver_later
  end

  task reschedule: :setup do
    GameMailer.reschedule(@game, @player, @sender, @body).deliver_later
  end

  task cancellation: :setup do
    GameMailer.cancellation(@game, @player, @sender, @body).deliver_later
  end
end
