class SupportsController < ApplicationController
  def create
    @character = Character.find(params[:character_id])
    @game = Game.find(@character.game_id)

    params[:support][:character] = @character
    params[:support][:partner] = Character.find_by(name: params[:support][:partner_name], game_id: @character[:game_id])
    params[:support].delete(:partner_name) # Get rid of extraneous field
    if params[:support][:partner] != nil # If there is no character with that name, don't make the support
      @support = @character.supports.create(support_params)
    end

    redirect_to game_character_path(@game, @character)
  end

  def destroy
    @character = Character.find(params[:character_id])
    @game = Game.find(@character.game_id)
    @support = @character.supports.find(params[:id])
    @support.destroy

    redirect_to game_character_path(@game, @character)
  end

  private
    def support_params
      # TODO: Fix the security on this later
      params.require(:support).permit!
    end
end
