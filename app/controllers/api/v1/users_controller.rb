module Api
  module V1
    class UsersController < ActionController::API

      def create
        if user
          render json: { user: user, message: 'User successfully created' }
        else
          render json: { error_message: user.errors.full_messages }
        end
      end

      private

      def user
        @user ||= User.create!(
          email: params[:email],
          name: params[:name]
        )
      end
    end
  end
end
