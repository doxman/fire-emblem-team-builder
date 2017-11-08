class GameValidator < ActiveModel::Validator
  def validate(game)
    if game.num_chapters < 1
      game.errors[:base] << "Game must have at least one chapter"
    end
  end
end
