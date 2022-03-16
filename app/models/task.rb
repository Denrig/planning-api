# frozen_string_literal: true

class Task < ApplicationRecord
  default_scope { order(created_at: :desc) }
  belongs_to :room
  has_many :votes, dependent: :destroy

  validates :text, presence: true

  before_save :update_other_tasks

  enum isssue_type: {
    bug: 1,
    task: 2,
    story: 3
  }

  def voting_results
    [0.5, 1, 2, 3, 5, 8, 13, 21, '?'].to_h do |points|
      [points, votes.where(vote: points).count]
    end
  end

  private

    def update_other_tasks
      return unless is_current

      current_task = room.tasks.find_by(is_current: true)

      return unless current_task

      current_task.update(is_current: false)

      room.broadcast({
                       type: :TASK_UPDATED,
                       task: TaskSerializer.new(current_task).serializable_hash.except(:votes)
                     })
    end
end
