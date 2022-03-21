# frozen_string_literal: true

class Tasks::UpdateService < BaseService
  parameters :task, :params

  def call
    ActiveRecord::Base.transaction do
      task.assign_attributes(params)

      @is_current_changed = task.is_current_changed?
      @is_result_changed = task.result_changed?

      current_voting_task&.update!(is_current: false) if @is_current_changed
      update_jira_card if @is_result_changed

      task.save!
    end

    broadcast_task_updated(task)
    broadcast_task_updated(current_voting_task) if @is_current_changed
    update_jira_card if @is_result_changed
  end

  private

    def current_voting_task
      @current_voting_task ||= room.tasks.find_by(is_current: true)
    end

    def room
      @room ||= task.room
    end

    # rubocop:disable Naming/VariableNumber
    def update_jira_card
      return if task.result == '?' || task.jira_id.nil?

      Jira::ApiService.update_card_information(task.jira_id,
                                               { fields: { customfield_10028: task.result.to_i } })
    end
    # rubocop:enable Naming/VariableNumber

    def broadcast_task_updated(updated_task)
      room.broadcast({
                       type: :TASK_UPDATED,
                       task: TaskSerializer.new(updated_task).serializable_hash.except(:votes)
                     })
    end
end
