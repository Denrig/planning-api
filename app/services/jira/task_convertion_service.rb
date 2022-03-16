# frozen_string_literal: true

class Jira::TaskConvertionService < BaseService
  parameter :id

  attr_reader :task

  def call
    params = Jira::ApiService.get_card_information(id)
    @task = Task.new(task_params(params))
  end

  private

    def task_params(params)
      {
        text: params['summary'],
        description: params['description'],
        status: params.dig('status', 'name'),
        issue_type: get_issue_type(params.dig('issuetype', 'name').downcase)
      }
    end

    def get_issue_type(value)
      Task.issue_types.keys.include?(value) ? value : nil
    end
end
