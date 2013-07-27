class PlayersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @players = Player.active.map(&:decorate)
    @ranked_players = PlayerRanker.by_games_played.limit(10)
  end

  def new
    @player = Player.new
  end

  def edit
    @player = Player.find(params[:id])
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to players_url, notice: 'Player was successfully created.'
    else
      flash.now[:error] = 'Failed to create player.'
      render :new
    end
  end

  def update
    @player = Player.find(params[:id])

    if @player.update_attributes(player_params)
      redirect_to players_url, notice: 'Player was successfully updated.'
    else
      flash.now[:error] = 'Failed to update player.'
      render :edit
    end
  end

  def destroy
    player = Player.find(params[:id])

    if player.destroy
      redirect_to players_url, notice: 'Player was successfully removed.'
    else
      redirect_to players_url, alert: player.errors.full_messages.join('. ')
    end
  end

private

  def player_params
    params.require(:player).permit(:access_token, :email, :first_name, :last_name, :phone)
  end
end
