module GamesHelper
  def score(game)
    player1 = game.rolls.player(game.player1)
    player2 = game.rolls.player(game.player2)

    player1_score = calculate_score(player1)
    player2_score = calculate_score(player2)
    [player1_score, player2_score]
  end

  def calculate_score(rolls)
    rolls.map(&:knocked_pins).inject(0) { |sum, n| sum + n }
  end
end
