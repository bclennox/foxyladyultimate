class ScheduleDecorator < ApplicationDecorator
  def available_days
    %w{Sunday Monday Tuesday Wednesday Thursday Friday Saturday}
  end
end
