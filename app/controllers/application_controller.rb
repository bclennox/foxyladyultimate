class ApplicationController < ActionController::Base
  protect_from_forgery

  def layout
    @layout ||= Layout.new
  end
  helper_method :layout
end
