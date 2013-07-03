class GamesController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :schedule, :remind, :cancel, :reschedule]
  before_filter :find_game, only: [:show, :edit, :update, :respond, :remind, :cancel, :reschedule]
  before_filter :find_player_by_params_access_token!, only: :respond
  before_filter :find_player_by_cookie_access_token, only: [:next, :show]

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

  def edit; end

  def update
    if @game.update_attributes(game_params)
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

    cookies.permanent[:access_token] = @player.access_token

    @game.respond(@player, playing)

    redirect_to @game, notice: notice
  end

  def remind
    @game.remind(current_user, params[:message])
    redirect_to @game, notice: 'Sent your message.'
  end

  def cancel
    @game.cancel(current_user, params[:message])
    redirect_to @game, notice: 'Canceled the game and sent your message.'
  end

  def reschedule
    @game.reschedule(current_user, params[:message])
    redirect_to @game, notice: 'Rescheduled the game and sent your message.'
  end

private

  def find_game
    @game = Game.find(params[:id]).decorate
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
