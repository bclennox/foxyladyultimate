class GamesController < ApplicationController
  before_filter :find_player_by_access_token, only: :respond

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])

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
    Game.seed
    redirect_to games_path, notice: 'Scheduled the next game.'
  end

  def respond
    game = Game.find(params[:id])
    playing = params[:playing] == 'yes'
    notice = playing ? 'See you there!' : 'Maybe next time.'

    Response.create(player_id: @player.id, game_id: game.id, playing: playing)

    redirect_to game, notice: notice
  end

private

  def find_player_by_access_token
    @player = Player.find_by_access_token(params[:access_token])
    redirect_to root_path unless @player
  end
end
