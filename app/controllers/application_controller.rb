class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :authorizer, :layout

  def authorizer
    @authorizer ||= Authorizer.new(user: current_user)
  end

  def layout
    @layout ||= Layout.new(application_name: 'Foxy Lady Ultimate', controller: self)
  end
end
