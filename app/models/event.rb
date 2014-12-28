class Event
  include ActiveModel::Model

  attr_accessor :game, :view_context

  def to_ical
    calendar.to_ical
  end

  private

  def calendar
    @calendar ||= Icalendar::Calendar.new.tap do |calendar|
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

  def url
    view_context.game_url(game)
  end

  def sequence
    game.updated_at.to_i - game.created_at.to_i
  end
end
