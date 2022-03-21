# frozen_string_literal: true

class Tasks::CreationService < BaseService
  parameters :params, :room

  attr_reader :task

  def call
    ActiveRecord::Base.transaction do
      room.tasks.update_all(is_current: false)
      @task = room.tasks.create(params.merge(is_current: true))
    end

    return unless @task
  end
end
