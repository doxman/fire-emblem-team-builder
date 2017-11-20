class TeamsController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @characters = Character.all.select { |c| c.game_id == params[:id].to_i }
      .sort { |c1, c2| [c2.rating, c1.recruitment_chapter, c1.id] <=> [c1.rating, c2.recruitment_chapter, c2.id] }
      .as_json(include: { partners: { only: [:name, :id] } },
                                      only: [:name, :id, :recruitment_chapter, :rating])
    @game = Game.find(params[:id])
  end
end
