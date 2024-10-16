require 'ice_cube'

class Schedule < ApplicationRecord
  validates :time, presence: true
  belongs_to :location

  def time=(t)
    write_attribute :time, parse_time(t)
  end

  def method_missing(method, *args)
    if ice_cube.respond_to?(method)
      ice_cube.send(method, *args)
    else
      super
    end
  end

  def recurrence
    "#{ice_cube} at #{time_in_time_zone}"
  end

private

  def ice_cube
    d = read_attribute :day
    t = read_attribute :time

    unless defined?(@ice_cube) || !(d && t)
      @ice_cube = IceCube::Schedule.new(epoch(t))
      @ice_cube.add_recurrence_rule IceCube::Rule.weekly.day(d.downcase.to_sym)
    end

    @ice_cube
  end

  def epoch(t)
    @epoch ||= begin
      hour, minute, second = t.split(':')
      Time.zone.local(2013, 1, 1, hour, minute, second)
    end
  end

  def time_in_time_zone
    Time.zone.parse(time).strftime('%l:%M%P').squish
  end

  def parse_time(t)
    Time.zone.parse(t).strftime('%H:%M:%S') rescue nil
  end
end
