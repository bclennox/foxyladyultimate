require 'ice_cube'

class Game < ActiveRecord::Base
  attr_accessible :location, :starts_at
  default_scope order('starts_at ASC')
  scope :upcoming, where('starts_at > NOW()')

  def self.seed(count = 1)
    schedule.next_occurrences(count).each do |datetime|
      find_or_create_by_starts_at!(datetime)
    end
  end

private

  def self.schedule
    unless defined? @schedule
      @schedule = IceCube::Schedule.new(Time.local(2012, 1, 6, 12))
      @schedule.add_recurrence_rule IceCube::Rule.weekly.day(:sunday)
    end

    @schedule
  end
end
