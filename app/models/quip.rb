class Quip < ApplicationRecord
  belongs_to :player
  validates :confirmation, :rejection, presence: true

  scope :approved, -> { where(approved: true) }
  scope :pending, -> { where(approved: nil) }
end
