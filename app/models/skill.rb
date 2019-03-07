class Skill < ApplicationRecord
  has_many :user_skills
  has_many :users, through: :user_skills

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :like_by_name, ->(str) { where('LOWER(name) LIKE ? ', "%#{str&.downcase}%") }
end
