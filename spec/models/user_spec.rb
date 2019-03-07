# frozen_string_literal: true

require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should have_many(:user_skills) }
  it { should have_many(:skills).through(:user_skills) }
  it { should have_many(:user_projects) }
  it { should have_many(:projects).through(:user_projects) }
  it { should have_many(:user_teams) }
  it { should have_many(:teams).through(:user_teams) }
  it { should have_one(:working_hour) }
  it { should have_many(:holidays) }
  it { should have_many(:employees) }

  context 'instance methods' do
    context 'on_leave_today?' do
      it 'should return false' do
        expect(user.on_leave_today?).to be_falsey
      end

      it 'should return true' do
        FactoryBot.create(:holiday, user_id: user.id)
        expect(user.on_leave_today?).to be_truthy
      end
    end

    context 'current_project' do
      it 'should return nil' do
        project = FactoryBot.create(:project)
        user.user_projects.create(
          user_id: user.id,
          project_id: project.id,
          end_date: Date.today - 1.day
        )
        expect(user.current_project).to be_falsey
      end

      it 'should return true' do
        project = FactoryBot.create(:project)
        user.user_projects.create(
          user_id: user.id,
          project_id: project.id,
          end_date: Date.today + 1.day
        )
        expect(user.current_project).to be_truthy
      end
    end

    context 'free_since' do
      it 'should return date' do
        project = FactoryBot.create(:project)
        user.user_projects.create(
          user_id: user.id,
          project_id: project.id,
          end_date: Date.today - 1.day
        )
        expect(user.free_since.present?).to be_truthy
      end

      it 'should return true' do
        project = FactoryBot.create(:project)
        user.user_projects.create(
          user_id: user.id,
          project_id: project.id,
          end_date: Date.today + 1.day
        )
        expect(user.free_since).to be_falsey
      end
    end
  end
end
