# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :room
  has_many :votes, dependent: :destroy

  validates :text, presence: true
end
