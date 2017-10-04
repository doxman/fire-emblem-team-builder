module CharactersHelper
  def otherCharactersFromTheSameGame(character)
    return Character.all.select { |c| c.game == character.game }
                        .reject { |c| c.name == character.name }
  end
end
