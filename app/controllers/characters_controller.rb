class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def show
    @character = Character.find(params[:id])
  end

  def new
    @character = Character.new
  end

  def edit
    @character = Character.find(params[:id])
  end

  def create
    @character = Character.new(character_params)

    if @character.save
      if helpers.otherCharactersFromTheSameGame(@character).length > 0
        redirect_to @character
      else
        redirect_to characters_path # No point showing character if we can't add supports
      end
    else
      render 'new'
    end
  end

  def update
    @character = Character.find(params[:id])

    if @character.update(character_params)
      if helpers.otherCharactersFromTheSameGame(@character).length > 0
        redirect_to @character
      else
        redirect_to characters_path # No point showing character if we can't add supports
      end
    else
      render 'edit'
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy

    redirect_to characters_path
  end

  private
    def character_params
      params.require(:character).permit(:name, :game)
    end
end
