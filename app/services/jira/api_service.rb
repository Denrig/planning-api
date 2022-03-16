# frozen_string_literal: true

class Jira::ApiService
  include HTTParty

  base_uri 'https://wolfpackdigital.atlassian.net/rest/api/2/issue'
  HEADERS = { Authorization: "Basic #{ENV.fetch('JIRA_API_KEY')}",
              'Content-Type': 'application/json' }.freeze

  class << self
    def get_card_information(id)
      response = get("/#{id}", headers: HEADERS)

      raise ActiveRecord::RecordNotFound if response.response.code == '404'

      response.parsed_response['fields']
    end

    def update_card_information(id, params)
      put("/#{id}", headers: HEADERS, body: params.to_json)
    end
  end
end
