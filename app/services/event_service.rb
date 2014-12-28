module EventService
  def self.create_event(game)
    url = url(game)
    sequence = sequence(game)

    Icalendar::Calendar.new.tap do |calendar|
      calendar.ip_method = game.canceled? ? 'CANCEL' : 'PUBLISH'
      calendar.event do |event|
        event.summary      = 'Ultimate Frisbee'
        event.dtstart      = game.starts_at.to_datetime
        event.duration     = 'PT3H'
        event.location     = game.location
        event.transp       = 'OPAQUE'
        event.url          = url
        event.uid          = url
        event.sequence     = sequence
        event.status       = game.canceled? ? 'CANCELLED' : 'TENTATIVE'
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
