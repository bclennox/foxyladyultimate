class Location < ApplicationRecord
  validates :name, :url, presence: true
  has_many :games
end
