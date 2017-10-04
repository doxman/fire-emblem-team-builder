module SupportsHelper
  include CharactersHelper

  def shouldSubmitBeDisabled?(character)
    return otherCharactersFromTheSameGame(character)
            .reject { |c| character.partners.include? c }
            .length == 0
  end

  def availableSupports(character)
    return otherCharactersFromTheSameGame(character)
            .reject { |c| character.partners.include? c }
            .collect { |c| c.name }
  end
end
