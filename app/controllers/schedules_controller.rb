class SchedulesController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @schedule = Schedule.instance.decorate
  end

  def update
    @schedule = Schedule.instance

    if @schedule.update_attributes(params[:schedule])
      redirect_to games_path, notice: 'Updated the schedule.'
    else
      render :edit
    end
  end
end
