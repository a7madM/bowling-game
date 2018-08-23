class RollsController < ApplicationController
  def create
    roll = Roll.create(roll_params)
    render json: { roll: roll }, status: :created
  end

  def roll_params
    params.require(:roll).permit(:game_id, :knocked_pins, :player)
  end
end
