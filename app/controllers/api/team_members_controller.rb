# frozen_string_literal: true

module Api
  class TeamMembersController < ApplicationController
    def index
      users = TeamMember::FilterInteraction.run!(
        team: Team.first,
        filters: filter_params.to_hash
      )
      users = users.order(id: :asc).page(params[:page]).per(params[:per])
      render json: custom_response(users).as_json
    end

    private

    def filter_params
      params.permit(
        :holidays,
        :working_hour,
        :first_name,
        :last_name,
        :project,
        :skills
      )
    end

    def serialize_array(users)
      ActiveModelSerializers::SerializableResource.new(
        users,
        each_serializer: TeamMemberSerializer
      ).as_json
    end

    def custom_response(users)
      {
        items: serialize_array(users),
        has_next: users.next_page.present?,
        has_previous: users.prev_page.present?,
        total_count: users.total_count,
        per: params[:per].present? ? params[:per].to_i : users.page(params[:page]).limit_value,
        page: users.current_page
      }
    end
  end
end
