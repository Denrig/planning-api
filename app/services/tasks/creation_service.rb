# frozen_string_literal: true

class Tasks::CreationService < BaseService
  parameters :params, :room

  attr_reader :task

  def call
    ActiveRecord::Base.transaction do
      @current_task = room.tasks.find_by(is_current: true)
      @current_task&.toggle!(:is_current)
      @task = room.tasks.create!(params.merge(is_current: true))
    end

    return unless @task

    room.broadcast({
                     type: :TASK_ADDED,
                     task: TaskSerializer.new(task).serializable_hash
                   })

    return unless @current_task

    room.broadcast({
                     type: :TASK_UPDATED,
                     task: TaskSerializer.new(@current_task).serializable_hash
                   })
  end
end
