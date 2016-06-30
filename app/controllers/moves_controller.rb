class MovesController < ApplicationController
  def create
    move = Dispatcher.run(move_params)
    render json: move
  end

  private

  def move_params
    {
      description: params.require(:description),
      address:     params.require(:address),
    }
  end
end
