# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Project, type: :model do
  it { should have_many(:user_projects) }
  it { should have_many(:users).through(:user_projects) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
