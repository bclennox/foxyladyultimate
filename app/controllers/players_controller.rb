class PlayersController < ApplicationController
  include AccessTokenController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_player, only: [:edit, :update, :destroy]
  before_action :set_player_from_session, only: [:index]

  decorates_assigned :player, :players

  def index
    @players = Player.active.includes(:confirmed_games)
  end

  def ranked
    @players = PlayerRanker
      .by_games_played(since: params[:since].to_i.months.ago)
      .limit(10)
  end

  def new
    @player = Player.new
  end

  def edit
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      PopulatePlayerShortNamesJob.perform_later
      redirect_to players_url, notice: 'Player was successfully created.'
    else
      flash.now[:alert] = "Failed to create player: #{@player.errors.to_a.to_sentence}"
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @player.update(player_params)
      PopulatePlayerShortNamesJob.perform_later
      redirect_to players_url, notice: 'Player was successfully updated.'
    else
      flash.now[:alert] = "Failed to update player: #{@player.errors.to_a.to_sentence}"
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @player.destroy
      redirect_to players_url, notice: 'Player was successfully removed.'
    else
      redirect_to players_url, alert: "Failed to remove player: #{@player.errors.to_a.to_sentence}"
    end
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:access_token, :email, :first_name, :last_name, :phone, :retired)
  end
end
