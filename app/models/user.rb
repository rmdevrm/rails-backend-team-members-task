class User < ApplicationRecord
  has_many :user_skills
  has_many :skills, through: :user_skills

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
end
