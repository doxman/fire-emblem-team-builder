class Support < ApplicationRecord
  belongs_to :character
  belongs_to :partner, class_name: "Character"

  after_create :create_inverse, unless: :has_inverse?
  after_destroy :destroy_inverses, if: :has_inverse?

  def create_inverse
    self.class.create(inverse_support_options)
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def has_inverse?
    self.class.exists?(inverse_support_options)
  end

  def inverses
    self.class.where(inverse_support_options)
  end

  def inverse_support_options
    { partner_id: character_id, character_id: partner_id }
  end

  validates :character, presence: true, uniqueness: { scope: :partner }
  validates_with SupportValidator
end
