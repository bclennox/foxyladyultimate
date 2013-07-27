class Response < ActiveRecord::Base
  belongs_to :player, touch: true
  belongs_to :game, touch: true
end
