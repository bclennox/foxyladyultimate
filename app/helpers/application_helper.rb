module ApplicationHelper
  def admin?
    current_user.present?
  end

  def body_class
    [controller.controller_name, controller.action_name].join(' ')
  end

  def relative_date(date)
    modifier = date < Time.now ? 'ago' : 'from now'
    time_ago_in_words(date) + ' ' + modifier
  end
end
