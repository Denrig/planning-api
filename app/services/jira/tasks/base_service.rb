# frozen_string_literal: true

class Jira::Tasks::BaseService < BaseService
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
