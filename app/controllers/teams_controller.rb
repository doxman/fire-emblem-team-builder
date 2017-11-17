class TeamsController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @characters = Character.all.select { |c| c.game_id == params[:id].to_i }
      .as_json(include: { partners: { only: [:name, :id] } },
                                      only: [:name, :id])
    @game = Game.find(params[:id])
  end
end
