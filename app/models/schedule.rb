require 'ice_cube'

class Schedule < ActiveRecord::Base
  attr_accessible :day, :time
  after_initialize :create_ice_cube

  def self.instance
    first
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
      Time.local(2013, 1, 1, hour, minute, second)
    end
  end
end
