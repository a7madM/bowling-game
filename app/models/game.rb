class Game < ApplicationRecord
  validates :player1, :player2, presence: true

  has_many :rolls
end
