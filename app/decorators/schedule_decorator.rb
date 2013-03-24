class ScheduleDecorator < Draper::Decorator
  delegate_all

  def available_days
    %w{Sunday Monday Tuesday Wednesday Thursday Friday Saturday}
  end
end
