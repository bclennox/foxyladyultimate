class ScheduleDecorator < ApplicationDecorator
  decorates_association :location

  def time_in_time_zone
    Time.zone.parse(time).strftime('%l:%M%P')
  end

  def available_days
    %w{Sunday Monday Tuesday Wednesday Thursday Friday Saturday}
  end
end
