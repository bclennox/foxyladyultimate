class GamesController < ApplicationController
  before_filter :ensure_games, only: :index

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
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

private

  def ensure_games
    Game.seed if Game.upcoming.empty?
  end
end
