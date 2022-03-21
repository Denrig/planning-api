# frozen_string_literal: true

# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  user_id    :uuid
#  task_id    :bigint
#  vote       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :vote, presence: true

  delegate :room, to: :task, allow_nil: false
end
