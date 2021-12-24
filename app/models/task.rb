# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :room

  validates :text, presence: true
end
