# frozen_string_literal: true

module Api
  class SkillsController < ApplicationController
    def autocomplete
      skills = params[:skills].present? ? Skill.like_by_name(params[:skills]) : []
      render json: skills
        .page(params[:page]).per(params[:per]),
             each_serializer: SkillSerializer, status: 200
    end
  end
end
