class Skill < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  scope :like_by_name, ->(str) { where('LOWER(name) LIKE ? ', "%#{str&.downcase}%") }
end
