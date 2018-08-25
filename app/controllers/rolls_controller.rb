class RollsController < ApplicationController
  def create
    roll = Roll.create(roll_params)
    if roll.persisted?
      render json: { roll: roll }, status: :created
    else
      render json: { errors: roll.errors }, status: :unprocessable_entity
    end
  end

  def roll_params
    params.require(:roll).permit(:game_id, :knocked_pins, :player)
  end
end
