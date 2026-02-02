class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_schedule, :set_locations

  decorates_assigned :schedule

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to games_path, notice: 'Updated the schedule.'
    else
      flash.now[:alert] = "Failed to update schedule: #{@schedule.errors.to_a.to_sentence}"
      render :edit, status: :unprocessable_content
    end
  end

private

  def set_schedule
    @schedule = Current.schedule
  end

  def set_locations
    @locations = Location.order(:name)
  end

  def schedule_params
    params.require(:schedule).permit(:day, :location_id, :time)
  end
end
