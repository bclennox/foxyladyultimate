class Quip < ApplicationRecord
  validates :confirmation, :rejection, presence: true

  scope :active, -> { where(active: true) }
end
