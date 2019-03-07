# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :user_teams
  has_many :teams, through: :user_teams
  has_one :working_hour
  has_many :holidays
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id', optional: true
  has_many :employees, class_name: 'User', foreign_key: 'manager_id'

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  def on_leave_today?
    holidays.where('start_date <= ? AND end_date >= ?',
                   Date.today,
                   Date.today).present?
  end

  def current_project
    user_project = user_projects.order(created_at: :desc).first
    user_project.end_date > Date.today ? user_project.project : nil
  end

  def free_since
    end_date = user_projects.order(created_at: :desc).first.end_date
    end_date < Date.today ? end_date : nil
  end
end
