module AccessTokenController
  extend ActiveSupport::Concern

  def set_player_by_params_access_token!
    @player = Player.find_by_access_token(params[:access_token]) or redirect_to(root_path)
  end

  def set_player_by_cookie_access_token
    @player = Player.find_by_access_token(params[:access_token]) ||
              Player.find_by_access_token(cookies[:access_token]) ||
              current_user&.player
  end
end
