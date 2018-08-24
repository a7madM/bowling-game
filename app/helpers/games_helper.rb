module GamesHelper
  def rolls(game)
    player1 = game.rolls.player(game.player1).to_a
    player2 = game.rolls.player(game.player2).to_a
    player1_rolls = player1.map(&:knocked_pins)
    player2_rolls = player2.map(&:knocked_pins)

    [player1_rolls, player2_rolls]
  end

end
