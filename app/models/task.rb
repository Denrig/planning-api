# frozen_string_literal: true

class Task < ApplicationRecord
  default_scope { order(created_at: :desc) }
  belongs_to :room
  has_many :votes, dependent: :destroy

  validates :text, presence: true

  def voting_results
    [0.5, 1, 2, 3, 5, 8, 13, 21, '?'].map do |points|
      [points, votes.where(vote: points).count]
    end.to_h
  end
end
