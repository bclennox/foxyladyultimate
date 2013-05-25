module DateFormatter
  def time_ago_in_words_with_modifier(date)
    modifier = date < Time.now ? 'ago' : 'from now'
    h.time_ago_in_words(date) + ' ' + modifier
  end
end
