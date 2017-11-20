class Character < ApplicationRecord
  belongs_to :game
  has_many :supports
  has_many :partners, through: :supports, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :game }
  validates :game, presence: true
  validates :recruitment_chapter, presence: true, numericality: { only_integer: true }
  validates :rating, presence: true, numericality: { only_integer: true }
  validates_with CharacterValidator
end
