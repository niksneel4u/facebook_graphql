# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ActionController::API

      before_action :assign_variables, :fetch_email_id, :user_exist, only: :groups_list
      before_action :user_exist, only: :add_fav_groups

      def groups_list
        result = @graph.get_connections('me', 'groups')
        @groups << result
        fetch_all_pages(result)
        @groups.flatten
        send_response
      end

      def add_fav_groups
        return render json: { message: 'User not exist' } if user.present?

        params.dig(:group_ids).each do |group_id|
          user.fav_groups.create!(
            group_id: group_id
          )
        end

        render json: { 
          fav_group_ids: user.fav_groups.pluck(:group_id),
          message: 'groups id added successfully' }
      end

      private

      def user_exist
        return if user.present?

        create_user
      end

      def user
        @user ||= User.find_by(email: params['email_id'] || @user_data['email'])
      end

      def create_user
        return if @user_data.blank?

        @user = User.create!(
          email: @user_data['email'],
          name: @user_data['name']
        )
      end

      def fetch_email_id
        @user_data = @graph.get_object('me', fields: 'email, name')

        return if @user_data['email'].present?

        render json: { message: 'Please Provide an email id' }
      end

      def assign_variables
        @groups = []
        @graph = Koala::Facebook::API.new(params[:token])
      end

      def send_response
        if @groups.present?
          render json: { user: user, groups: @groups }
        else
          render json: { message: 'Groups not found' }
        end
      end

      def fetch_all_pages(result)
        while result.count == GlobalConstants::RESULTS_PER_PAGE do
          next_page = result.next_page
          @groups << next_page if next_page.present?

          result = next_page
        end
      end
    end
  end
end
