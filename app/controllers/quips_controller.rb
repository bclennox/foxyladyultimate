class QuipsController < ApplicationController
  include AccessTokenController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_player_by_cookie_access_token, only: [:index, :create]
  before_action :set_player_by_params_access_token!, only: [:new]

  after_action :set_access_token, only: [:new]

  decorates_assigned :quips, :quip, :player

  def index
    @quips = Quip
      .includes(:player)
      .order('approved DESC NULLS FIRST')
      .order(updated_at: :desc)
      .page(params[:page])
  end

  def new
    @quip = Quip.new(player: @player)
  end

  def create
    @quip = Quip.new(quip_params_for_create.merge(player: @player))

    if @quip.save
      redirect_to quips_path, notice: "Submitted your quip! Once it's approved, look for it in the weekly emails."
    else
      flash.now[:alert] = 'Failed to create the quip.'
      render :new
    end
  end

  def edit
    @quip = Quip.find(params[:id])
  end

  def update
    @quip = Quip.find(params[:id])

    if @quip.update(quip_params_for_update)
      redirect_to quips_path, notice: 'Updated the quip.'
    else
      flash.now[:alert] = 'Failed to update the quip.'
      render :edit
    end
  end

  private

  def quip_params_for_create
    params.require(:quip).permit(:confirmation, :rejection)
  end

  def quip_params_for_update
    params.require(:quip).permit(:confirmation, :rejection, :approved)
  end
end
