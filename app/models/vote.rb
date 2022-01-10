# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :vote, presence: true

  delegate :room, to: :task, allow_nil: false
end
