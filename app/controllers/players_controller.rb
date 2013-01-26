class PlayersController < ApplicationController
  def index
    if params.key?(:game_id)
      @game = Game.find(params[:game_id])
      @players = @game.players.all
    else
      @game = nil
      @players = Player.all
    end
  end

  def new
    @player = Player.new
  end

  def edit
    @player = Player.find(params[:id])
  end

  def create
    @player = Player.new(params[:player])

    if @player.save
      redirect_to players_url, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  def update
    @player = Player.find(params[:id])

    if @player.update_attributes(params[:player])
      redirect_to players_url, notice: 'Player was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    redirect_to players_url
  end
end
