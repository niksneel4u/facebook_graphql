module Api
  module V1
    class UsersController < ActionController::API

      before_action :user, only: :add_notification_time

      def create
        if user
          render json: { user: user, message: 'User successfully created' }
        else
          render json: { error_message: user.errors.full_messages }
        end
      end

      def add_notification_time
        if user.update(mail_trigger_time: Time.parse(params['time']))
          render json: { message: 'Time updated successfully' }
        else
          render json: { error_message: user.errors.full_messages }
        end
      end

      private

      def user
        @user = User.find_by(email: params['email'])
      end

      def user
        @user ||= User.create!(
          email: params[:email],
          name: params[:name]
        )
      end
    end
  end
end
