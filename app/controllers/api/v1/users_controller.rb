# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::BaseController
  def index
    render json: user
  end

  def create
    render json: User.create!(user_params)
  end

  def update
    render json: user.update!(user_params.exept(:role))
  end

  private

    def user_params
      params.require(:user).permit(:name, :character_image, :role)
    end

    def user
      @user ||= User.find(request.headers[:userId]) if request.headers[:userId]
    end
end
