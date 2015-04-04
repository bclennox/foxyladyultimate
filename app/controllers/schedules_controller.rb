class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_schedule

  decorates_assigned :schedule

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to games_path, notice: 'Updated the schedule.'
    else
      flash.now[:error] = 'Failed to update the schedule.'
      render :edit
    end
  end

private

  def set_schedule
    @schedule = Schedule.instance
  end

  def schedule_params
    params.require(:schedule).permit(:day, :location, :time)
  end
end
