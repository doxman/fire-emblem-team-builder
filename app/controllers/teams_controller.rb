class TeamsController < ApplicationController
  def index
    @unpicked = Character.all
    @team = []
  end

  def add_member
    @unpicked = Character.all.select{ |c| params[:unpicked].include? c.id.to_s and params[:character_id] != c.id.to_s }
    @team = Character.all.reject{ |c| params[:unpicked].include? c.id.to_s and params[:character_id] != c.id.to_s }

    render 'index'
  end

  def remove_member
    @unpicked = Character.all.select{ |c| params[:unpicked].include? c.id.to_s or params[:character_id] == c.id.to_s }
    @team = Character.all.reject{ |c| params[:unpicked].include? c.id.to_s or params[:character_id] == c.id.to_s }

    render 'index'
  end
end
