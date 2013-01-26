module ApplicationHelper
  def relative_date(date)
    modifier = date < Time.now ? 'ago' : 'from now'
    time_ago_in_words(date) + ' ' + modifier
  end
end
