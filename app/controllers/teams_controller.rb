class TeamsController < ApplicationController
  def index
    @characters = Character.all.as_json(include: { partners: { only: [:name, :id] } },
                                        only: [:name, :id])

    # gon.unpicked = Character.all.as_json(:include => [:partners])
    # gon.team = []
  end
end
