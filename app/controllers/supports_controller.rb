class SupportsController < ApplicationController
  def index
    @character = Character.find(params[:character_id])
    @supports = @character.supports
  end

  def create
    @character = Character.find(params[:character_id])
    @support = @character.supports.create(support_params)
    redirect_to character_path(@character)
  end

  def destroy
    @character = Character.find(params[:character_id])
    @support = @character.supports.find(params[:id])
    @support.destroy
    redirect_to character_path(@character)
  end

  private
    def support_params
      params.require(:support).permit(:character, :partner)
    end
end
