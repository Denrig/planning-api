# frozen_string_literal: true

class Jira::Tasks::ConvertionService < Jira::Tasks::BaseService
  parameter :id

  attr_reader :task

  def call
    params = Jira::ApiService.get_card_information(id)
    @task = Task.new(task_params(params))
  end
end
