class PlayersController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @players = Player.active.all.map(&:decorate)
    @ranked_players = PlayerRanker.games_played.limit(10)
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
      flash.now[:error] = 'Failed to create player.'
      render :new
    end
  end

  def update
    @player = Player.find(params[:id])

    if @player.update_attributes(params[:player])
      redirect_to players_url, notice: 'Player was successfully updated.'
    else
      flash.now[:error] = 'Failed to update player.'
      render :edit
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    redirect_to players_url, notice: 'Player was successfully removed.'
  end
end
