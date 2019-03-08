# frozen_string_literal: true

module Api
  class ProjectsController < ApplicationController
    before_action :find_project, only: :assign_user
    before_action :find_users, only: :assign_user

    def autocomplete
      if params[:projects].present?
        projects = Project.like_by_name(params[:projects])
        render json: projects
          .page(params[:page]).per(params[:per]),
               each_serializer: ProjectSerializer, status: 200
      else
        render json: []
      end
    end

    def assign_user
      result = Project::AssignUserInteraction.run(
        project: @project,
        user: @user
      )
      if result.valid?
        render json: result
      else
        render json: { errors: result.errors }, status: 422
      end
    end

    private

    def find_project
      @project = Project.find_by_id(params[:id])
      return render json: { errors: 'Project not found', status: 404 } if @project.blank?
    end

    def find_users
      @user = User.where(id: params[:user_id]).first
    end
  end
end
