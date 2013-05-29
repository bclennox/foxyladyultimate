class PlayersController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @players = PlayerRanker.games_played
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
