class Game < ApplicationRecord
  has_many :characters, dependent: :destroy

  validates :name, presence: true
  validates :full_name, presence: true
  validates :difficulty, uniqueness: { scope: :name }
end
