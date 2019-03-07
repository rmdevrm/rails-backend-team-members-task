# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :user_teams
  has_many :teams, through: :user_teams
  has_one :working_hour

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
end
