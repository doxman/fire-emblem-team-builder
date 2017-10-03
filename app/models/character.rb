class Character < ApplicationRecord
  has_many :supports
  has_many :partners, through: :supports, dependent: :destroy
end
