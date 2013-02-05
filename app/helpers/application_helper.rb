module ApplicationHelper
  def admin?
    current_user.present?
  end

  def relative_date(date)
    modifier = date < Time.now ? 'ago' : 'from now'
    time_ago_in_words(date) + ' ' + modifier
  end
end
