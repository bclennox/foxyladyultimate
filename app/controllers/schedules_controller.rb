class SchedulesController < ApplicationController
  def edit
    @schedule = Schedule.instance
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
