class Team < ApplicationRecord
  has_many :user_teams
  has_many :users, through: :user_teams

  validates :name, presence: true
  validates :name, uniqueness: true
end
