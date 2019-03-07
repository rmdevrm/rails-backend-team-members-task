# frozen_string_literal: true

module Api
  class ProjectsController < ApplicationController
    def autocomplete
      if params[:projects].present?
        render json: projects
          .page(params[:page]).per(params[:per]),
               each_serializer: ProjectSerializer, status: 200
      else
        render json: []
      end
    end
  end
end