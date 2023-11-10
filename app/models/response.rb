class Response < ApplicationRecord
  belongs_to :player, touch: true
  belongs_to :game, touch: true

  scope :confirmed, -> { where(playing: true) }
  scope :declined, -> { where(playing: false) }
end
