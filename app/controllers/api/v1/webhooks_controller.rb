# frozen_string_literal: true

class Api::V1::WebhooksController < ApplicationController
  def create
    Jira::Tasks::CreationService.call(params: params.permit!)

    head :ok
  end
end
