class Roll < ApplicationRecord
  belongs_to :game
  validates :game, presence: true
  validates :player, presence: true
  validates :knocked_pins, presence: true, inclusion: { in: 0..10 }
end
