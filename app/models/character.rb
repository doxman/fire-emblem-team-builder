class Character < ApplicationRecord
  belongs_to :game
  has_many :supports
  has_many :partners, through: :supports, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :game }
  validates :game, presence: true
end
