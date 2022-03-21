# frozen_string_literal: true

class Jira::Tasks::CreationService < Jira::Tasks::BaseService
  parameter :params

  attr_reader :task

  def call
    fields = params.dig(:issue, :fields)
    room = Room.find_by(jira_key: fields.dig(:project, :key))

    return unless room

    @task = ::Tasks::CreationService.call(
      params: task_params(fields).merge(jira_id: params.dig(:issue, :key)),
      room: room
    ).task
  end
end
