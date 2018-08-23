class GamesController < ApplicationController
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
    render json: { data: game }
  end

  private

  def find_game
    Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:player1, :player2)
  end
end
