# encoding: utf-8
require 'ice_cube'

class Schedule < ActiveRecord::Base
  attr_accessible :day, :location, :time
  after_initialize :create_ice_cube
  before_validation :parse_time

  validates :time, presence: true

  def self.instance
    first
  end

  def to_s
    "#{@ice_cube} at #{Time.zone.parse(time).strftime('%l:%M%P')} — #{location}"
  end

  def method_missing(method, *args)
    if @ice_cube.respond_to?(method)
      @ice_cube.send(method, *args)
    else
      super
    end
  end

private

  def create_ice_cube
    @ice_cube = IceCube::Schedule.new(epoch)
    @ice_cube.add_recurrence_rule IceCube::Rule.weekly.day(day.downcase.to_sym)
  end

  def epoch
    @epoch ||= begin
      hour, minute, second = time.split(':')
      Time.zone.local(2013, 1, 1, hour, minute, second)
    end
  end

  def parse_time
    parsed = Time.zone.parse(time).strftime('%H:%M:%S') rescue nil
    write_attribute(:time, parsed)
  end
end
