# frozen_string_literal: true

class Api::V1::BaseController < ActionController::API
  include ApiErrorHandling

  def pagination_params
    { page: params[:page] || 1, per_page: params[:per_page] || 15 }
  end

  def paginate(data)
    data.paginate(pagination_params).tap do |result|
      response.set_header('X-total', result.total_entries)
      response.set_header('X-current-page', result.current_page)
      response.set_header('X-per-page', result.per_page)
    end
  end
end
