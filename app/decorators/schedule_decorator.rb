class ScheduleDecorator < ApplicationDecorator
  decorates_association :location

  def summary
    "#{recurrence} — #{location.link}".html_safe
  end

  def available_days
    %w{Sunday Monday Tuesday Wednesday Thursday Friday Saturday}
  end
end
