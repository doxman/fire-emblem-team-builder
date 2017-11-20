class CharacterValidator < ActiveModel::Validator
  def validate(character)
    numChapters = Game.find(character.game_id).num_chapters
    if character.recruitment_chapter < 1 or character.recruitment_chapter > numChapters
      character.errors[:base] << "Character must have a valid recruitment chapter"
    end
    if character.rating < 1 or character.rating > 5
      character.errors[:base] << "Character rating must be an integer within [1,5]"
    end
  end
end
