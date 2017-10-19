class TeamsController < ApplicationController
  def index
    gon.unpicked = Character.all.as_json(:include => [:partners])
    gon.team = []
  end
end
