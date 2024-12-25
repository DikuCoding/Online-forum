module Api
  module V1
    class AuthenticationController < ApplicationController
      require 'jwt'
      # POST /api/v1/signup
      def signup
        user = User.new(user_params)
        if user.save
          token = encode_token(user.id)
          render json: {user: user, token: token}, status: :created
        else
          render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
      end

      #POST /api/v1/login
      def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          token = encode_token(user.id)
          render json: { user: user, token: token }, status: :ok
        else
          render json: {errors: ['Invalid email or password']}, status: :unauthorized
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      def encode_token(user_id)
        payload = { user_id: user_id, exp: 24.hours.from_now.to_i }
        JWT.encode(payload, Rails.application.credentials.jwt_secret)
      end

    end
  end
end

