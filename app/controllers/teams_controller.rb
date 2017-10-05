class TeamsController < ApplicationController
  def index
    @unpicked = Character.all
    @team = []
  end

  def add_member
    @unpicked = Character.all.select{ |c| params[:unpicked].include? c.id.to_s }
                             .reject{ |c| params[:character_id] == c.id.to_s }
    @team = Character.all.reject{ |c| params[:unpicked].include? c.id.to_s }
                         .push(Character.find(params[:character_id]))

    render 'index'
  end

  def remove_member
    @unpicked = Character.all.select{ |c| params[:unpicked].include? c.id.to_s }
                             .push(Character.find(params[:character_id]))
    @team = Character.all.reject{ |c| params[:unpicked].include? c.id.to_s }
                         .reject{ |c| params[:character_id] == c.id.to_s }

    render 'index'
  end
end
