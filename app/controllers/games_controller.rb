class GamesController < ApplicationController
  before_filter :find_game, only: [:show, :edit, :update, :respond, :remind, :cancel, :reschedule]
  before_filter :find_player_by_access_token, only: :respond

  def index
    @games = Game.all
  end

  def show; end
  def edit; end

  def update
    if @game.update_attributes(params[:game])
      redirect_to games_path, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  def next
    @game = Game.upcoming.last
  end

  def schedule
    game = Game.seed
    redirect_to game, notice: 'Scheduled the next game.'
  end

  def respond
    playing = params[:playing] == 'yes'
    notice = playing ? 'See you there!' : 'Maybe next time.'

    @game.respond(@player, playing)

    redirect_to @game, notice: notice
  end

  def remind
    @game.remind(params[:message])
    redirect_to @game, notice: 'Sent your message.'
  end

  def cancel
    @game.cancel(params[:message])
    redirect_to @game, notice: 'Canceled the game and sent your message.'
  end

  def reschedule
    @game.reschedule(params[:message])
    redirect_to @game, notice: 'Rescheduled the game and sent your message.'
  end

private

  def find_game
    @game = Game.find(params[:id])
  end

  def find_player_by_access_token
    @player = Player.find_by_access_token(params[:access_token])
    redirect_to root_path unless @player
  end
end
