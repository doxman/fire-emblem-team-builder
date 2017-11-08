class Game < ApplicationRecord
  has_many :characters, dependent: :destroy

  validates :name, presence: true
  validates :full_name, presence: true
  validates :difficulty, presence: true, uniqueness: { scope: :name }
  validates :num_chapters, presence: true, numericality: { only_integer: true }
  validates_with GameValidator
end
