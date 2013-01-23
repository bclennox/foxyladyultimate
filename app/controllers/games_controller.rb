class GamesController < ApplicationController
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

  def schedule
    Game.seed
    redirect_to games_path, notice: 'Scheduled the next game.'
  end
end
