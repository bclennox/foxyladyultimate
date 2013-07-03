class SchedulesController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @schedule = Schedule.instance.decorate
  end

  def update
    @schedule = Schedule.instance.decorate

    if @schedule.update_attributes(schedule_params)
      redirect_to games_path, notice: 'Updated the schedule.'
    else
      flash.now[:error] = 'Failed to update the schedule.'
      render :edit
    end
  end

private

  def schedule_params
    params.require(:schedule).permit(:day, :location, :time)
  end
end
