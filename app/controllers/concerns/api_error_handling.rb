# frozen_string_literal: true

module ApiErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from CustomError do |error|
      render json: {
        message: error.to_s,
        code: 'unprocessable_entity'
      }, status: :unprocessable_entity
    end

    rescue_from NotAuthorized do |error|
      render json: {
        message: error.message || 'Not authorized',
        code: 'unauthorized'
      }, status: :unauthorized
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      render json: {
        message: "#{exception.model} not found!",
        code: 'not_found'
      }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      render json: {
        message: 'Validation Failed',
        errors: exception.record.errors.full_messages,
        code: 'unprocessable_entity'
      }, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |exception|
      render json: {
        message: "Parameter missing: #{exception.param}",
        code: 'param_missing'
      }, status: :unprocessable_entity
    end

    rescue_from ActionController::BadRequest do |exception|
      render json: {
        message: exception.message,
        code: 'bad_request'
      }, status: :bad_request
    end

    rescue_from ActionController::InvalidAuthenticityToken do |exception|
      render json: {
        message: exception.message,
        code: 'invalid_authenticity_token'
      }, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordNotDestroyed do |exception|
      render json: {
        message: 'Destroy unsuccessful',
        errors: exception.record.errors,
        code: 'unprocessable_entity'
      }, status: :unprocessable_entity
    end

    # rescue_from ArgumentError do |error|
    #   render json: {
    #     message: "Argument error: #{error}",
    #     code: 'argument_error'
    #   }, status: :unprocessable_entity
    # end
  end
end
