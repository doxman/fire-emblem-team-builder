class Game < ApplicationRecord
  has_many :characters, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :full_name, presence: true
end
