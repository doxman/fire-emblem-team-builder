class CharactersController < ApplicationController
  def show
    @game = Game.find(params[:game_id])
    @character = Character.find(params[:id])
  end

  def edit
    @game = Game.find(params[:game_id])
    @character = Character.find(params[:id])
  end

  def create
    @game = Game.find(params[:game_id])
    params[:character][:game] = @game

    @character = Character.new(character_params)

    if @character.save
      if helpers.otherCharactersFromTheSameGame(@character).length > 0
        redirect_to game_character_path(@game, @character)
      else
        redirect_to game_path(@game) # No point showing character if we can't add supports
      end
    else
      redirect_to game_path(@game)
    end
  end

  def update
    @game = Game.find(params[:game_id])
    @character = Character.find(params[:id])

    if @character.update(character_params)
      if helpers.otherCharactersFromTheSameGame(@character).length > 0
        redirect_to game_character_path(@game, @character)
      else
        redirect_to game_path(@game) # No point showing character if we can't add supports
      end
    else
      render 'edit'
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    @character = Character.find(params[:id])
    @character.destroy

    redirect_to game_path(@game)
  end

  private
    def character_params
      # TODO: Fix the security on this later
      params.require(:character).permit!
    end
end
