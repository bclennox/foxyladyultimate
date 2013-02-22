module EventService
  def self.create_event(game)
    url = url(game)
    sequence = sequence(game)

    Icalendar::Calendar.new.tap do |calendar|
      calendar.ip_method = game.canceled? ? 'CANCEL' : 'PUBLISH'
      calendar.event do
        summary       'Ultimate Frisbee'
        start         game.starts_at.to_datetime
        duration      'PT3H'
        location      game.location
        transparency  'OPAQUE'
        url           url
        uid           url
        sequence      sequence
        status        game.canceled? ? 'CANCELLED' : 'TENTATIVE'
      end
    end
  end

private

  # surely a better way
  def self.url(game)
    "http://#{ActionMailer::Base.default_url_options[:host]}/games/#{game.id}"
  end

  def self.sequence(game)
    game.updated_at.to_i - game.created_at.to_i
  end
end
