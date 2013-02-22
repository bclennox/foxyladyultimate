module EventService
  def self.create_event(game)
    url = game_url(game)

    Icalendar::Calendar.new.tap do |calendar|
      calendar.event do
        summary       'Ultimate Frisbee'
        start         game.starts_at.to_datetime
        duration      'PT3H'
        location      game.location
        transparency  'OPAQUE'
        uid           url
        url           url
      end
    end
  end

private

  # surely a better way
  def self.game_url(game)
    "http://#{ActionMailer::Base.default_url_options[:host]}/games/#{game.id}"
  end
end
