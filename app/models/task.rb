# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :room
  has_many :votes, dependent: :destroy

  validates :text, presence: true

  def voting_results
    [0.5, 1, 3, 5, 8, 13, 21, '?'].map do |points|
      [points, votes.where(vote: points).count]
    end.to_h
  end
end
