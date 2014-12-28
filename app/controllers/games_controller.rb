class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :schedule, :remind, :cancel, :reschedule]
  before_action :find_game, only: [:show, :edit, :update, :respond, :override, :remind, :cancel, :reschedule]
  before_action :find_player_by_params_access_token!, only: :respond
  before_action :find_player_by_cookie_access_token, only: [:next, :show]

  after_action :set_access_token, only: [:respond]

  def index
    @games = Game.all.map(&:decorate)
  end

  def show
    respond_to do |format|
      format.html
      format.ics do
        send_data EventService.create_event(@game).to_ical, filename: 'ultimate.ics'
      end
    end
  end

  def edit
  end

  def update
    if @game.update(game_params)
      redirect_to games_path, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  def next
    @game = Game.upcoming.last.try(:decorate)
  end

  def schedule
    redirect_to Game.seed, notice: 'Scheduled the next game.'
  end

  def respond
    playing = params[:playing] == 'yes'
    notice = playing ? 'See you there!' : 'Maybe next time.'

    @game.respond(@player, playing)

    redirect_to @game, notice: notice
  end

  def override
    player = Player.find(params[:player_id])

    if params[:played] == 'yes'
      @game.respond(player, true)
      redirect_to @game, notice: "Added #{player.short_name} to the game."
    else
      @game.responses.where(player_id: player.id).destroy_all
      redirect_to @game, notice: "Removed #{player.short_name} from the game."
    end
  end

  def remind
    notifier.send_reminder
    redirect_to @game, notice: 'Sent your message.'
  end

  def cancel
    @game.update(canceled: true)
    notifier.send_cancellation
    redirect_to @game, notice: 'Canceled the game and sent your message.'
  end

  def reschedule
    @game.update(canceled: false)
    notifier.send_reschedule
    redirect_to @game, notice: 'Rescheduled the game and sent your message.'
  end

private

  def notifier
    GameNotifier.new(game: @game.object, sender: current_user, body: params[:message])
  end

  def find_game
    @game = Game.find(params[:id]).decorate
  end

  def set_access_token
    cookies.permanent[:access_token] = @player.access_token
  end

  def find_player_by_params_access_token!
    @player = Player.find_by_access_token(params[:access_token])
    redirect_to root_path unless @player
  end

  def find_player_by_cookie_access_token
    @player = Player.find_by_access_token(cookies[:access_token])
  end

  def game_params
    params.require(:game).permit(:canceled, :location, :starts_at)
  end
end
