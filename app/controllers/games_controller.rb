class GamesController < ApplicationController
  include GamesHelper

  def create
    game = Game.create(game_params)
    if game.persisted?
      render json: { game: game }, status: :created
    else
      render json: { errors: game.errors }, status: :unprocessable_entity
    end
  end

  def show
    game = find_game
    rolls1, rolls2 = rolls(game)
    score1 = BowlingScore.new(rolls1).score
    score2 = BowlingScore.new(rolls2).score
    render json: { data: game, score1: score1, score2: score2 }
  end

  private

  def find_game
    Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:player1, :player2)
  end
end
