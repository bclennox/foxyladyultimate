class QuipsController < ApplicationController
  before_action :authenticate_user!

  decorates_assigned :quips, :quip

  def index
    @quips = Quip.order(:confirmation)
  end

  def new
    @quip = Quip.new
  end

  def create
    @quip = Quip.new(quip_params)

    if @quip.save
      redirect_to quips_path, notice: "Created the quip."
    else
      flash.now[:alert] = "Failed to create quip: #{@quip.errors.to_a.to_sentence}"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @quip = Quip.find(params[:id])
  end

  def update
    @quip = Quip.find(params[:id])

    if @quip.update(quip_params)
      redirect_to quips_path, notice: 'Updated the quip.'
    else
      flash.now[:alert] = "Failed to update quip: #{@quip.errors.to_a.to_sentence}"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def quip_params
    params.require(:quip).permit(:confirmation, :rejection, :active)
  end
end
