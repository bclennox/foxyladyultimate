class ApplicationController < ActionController::Base
  protect_from_forgery

  def layout
    @layout ||= Layout.new
  end
  helper_method :layout

  def authorizer
    @authorizer ||= Authorizer.new(user: current_user)
  end
  helper_method :authorizer
end
