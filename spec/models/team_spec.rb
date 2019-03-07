# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Team, type: :model do
  it { should have_many(:user_teams) }
  it { should have_many(:users).through(:user_teams) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
