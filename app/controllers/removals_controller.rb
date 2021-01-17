class RemovalsController < ApplicationController
  include AccessTokenController

  before_action :set_player_by_params_access_token!
  decorates_assigned :player

  def new
  end

  def create
    if player.email != params[:removal][:email]
      redirect_to new_removal_path(access_token: player.access_token), alert: "Your email didn't match our records. Please check it again."
    else
      player.destroy
      redirect_to players_path, notice: 'Removed you from the list. Let us know if you ever want to come back!'
    end
  end
end
