class SupportValidator < ActiveModel::Validator
  def validate(support)
    if support.character.name == support.partner.name
      support.errors[:base] << "Self-supports are not permitted"
    elsif support.character.game_id != support.partner.game_id
      support.errors[:base] << "Support partners must be in the same game!"
    end
  end
end
