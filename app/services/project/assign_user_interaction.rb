# frozen_string_literal: true

class Project::AssignUserInteraction < ActiveInteraction::Base
  object :project
  object :user

  validates :project, presence: true
  validates :user, presence: true

  def execute
    sleep(10)
    # project.users << users
    { message: 'Assigned user successfully to the project', status: 200 }
  rescue StandardError => e
    errors.add(:base, 'Something went wrong')
  end
end
