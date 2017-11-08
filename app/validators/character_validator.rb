class CharacterValidator < ActiveModel::Validator
  def validate(character)
    numChapters = Game.find(character.game_id).num_chapters
    if character.recruitment_chapter < 1 or character.recruitment_chapter > numChapters
      character.errors[:base] << "Character must have a valid recruitment chapter"
    end
  end
end
