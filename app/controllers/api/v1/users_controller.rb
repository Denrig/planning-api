# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::BaseController
  def show
    render json: user
  end

  def create
    render json: User.create!(user_params)
  end

  def update
    user.update!(user_params)

    render json: user
  end

  private

    def user_params
      params.require(:user).permit(:name, :character_image)
    end

    def user
      @user ||= User.find(params[:id])
    end
end
