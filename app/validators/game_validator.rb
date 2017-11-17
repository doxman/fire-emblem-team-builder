class GameValidator < ActiveModel::Validator
  def validate(game)
    if game.num_chapters < 1
      game.errors[:base] << "Game must have at least one chapter"
    end
    if game.min_team_size < 1
      game.errors[:base] << "Game must have a minimum recommended team size"
    end
    if game.max_team_size < game.min_team_size
      game.errors[:base] << "Game must have a maximum recommended team size"
    end
  end
end
