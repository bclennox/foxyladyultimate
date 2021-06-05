class Quip < ApplicationRecord
  belongs_to :player
  validates :confirmation, :rejection, presence: true

  scope :pending, -> { where(approved: nil) }

  def self.random
    order('RANDOM()').first
  end
end
