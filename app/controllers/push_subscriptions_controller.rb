class PushSubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.push_subscriptions.find_or_create_by!(endpoint: params[:endpoint]) do |sub|
      sub.p256dh = params[:p256dh]
      sub.auth = params[:auth]
    end

    head :created
  end

  def destroy
    current_user.push_subscriptions.where(endpoint: params[:endpoint]).destroy_all

    head :ok
  end
end
