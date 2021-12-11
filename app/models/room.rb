class Room < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :players_count, presence: true, numericality: { greater_than: 0 }

  scope :active, -> { where(active: true) }
end
