class Roll < ApplicationRecord

  belongs_to :game
  validates :game, presence: true
  validates :player, presence: true
  validates :knocked_pins, presence: true, inclusion: { in: 0..10 }
  scope :player, ->(player) { where(player: player) }

  after_create do |roll|
    Roll.create(game_id: roll.game_id, player: roll.player, knocked_pins: 0) if roll.knocked_pins == 10
    # create new empty roll after strike to finish the frame
    # frame considered to be 2 attempts of rolling ball. I think it can be designed better than this.
  end
end
