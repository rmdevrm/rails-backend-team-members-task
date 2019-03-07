# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    before_action :find_user, only: %i[show update destroy]

    def index
      render json: User.all, each_serializer: UserSerializer, status: 200
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: user
      else
        render json: { errors: user.errors.as_json }, status: 422
      end
    end

    def show
      render json: @user
    end

    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: { errors: @user.errors.as_json }, status: 422
      end
    end

    def destroy
      if @user.destroy
        render json: { message: 'User Successfully destroy' }
      else
        render json: { errors: @user.errors }, status: 422
      end
    end

    private

    def find_user
      @user = User.find_by_id(params[:id])
      return render json: { errors: ['User not found'] }, status: 404 if @user.blank?
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
  end
end
