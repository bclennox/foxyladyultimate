class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :authorizer, :layout
  after_action :store_location

  def authorizer
    @authorizer ||= Authorizer.new(user: current_user)
  end

  def layout
    @layout ||= Layout.new(application_name: 'Foxy Lady Ultimate', controller: self, view_context: view_context)
  end

private

  def store_location
    unless request.fullpath.start_with?('/users') || request.xhr?
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end
end
