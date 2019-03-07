# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :user_projects
  has_many :users, through: :user_projects

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :like_by_name, ->(str) { where('LOWER(name)1 LIKE ? ', "%#{str&.downcase}%") }
end
