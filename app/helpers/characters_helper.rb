module CharactersHelper
  def otherCharactersFromTheSameGame(character)
    return Character.all.select { |c| c.game_id == character.game_id }
                        .reject { |c| c.name == character.name }
  end
end
