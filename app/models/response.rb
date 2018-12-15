class Response < ApplicationRecord
  belongs_to :player, touch: true
  belongs_to :game, touch: true
end
