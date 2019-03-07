# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::TeamMembersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:team) { FactoryBot.create(:team) }
  let(:skill) { FactoryBot.create(:skill) }
  let(:project) { FactoryBot.create(:project) }
  let!(:working_hour) { FactoryBot.create(:working_hour, user_id: user.id) }

  describe 'GET :index' do
    it 'should retun team_members' do
      user.teams << team
      user.skills << skill
      user.user_projects.create(
        user_id: user.id,
        project_id: project.id,
        end_date: Date.today
      )

      get :index, params: { skills: user.skills.map(&:name) }
      body = JSON.parse(response.body)
      expect(body['items'].present?).to be_truthy
      expect(body['items'].count > 0).to be_truthy
      expect(response.status).to be(200)
    end

    it 'should retun team_members with project_id' do
      user.teams << team
      user.skills << skill
      user.user_projects.create(
        user_id: user.id,
        project_id: project.id,
        end_date: Date.today
      )

      get :index, params: { projects: user.projects.map(&:id) }
      body = JSON.parse(response.body)
      expect(body['items'].present?).to be_truthy
      expect(body['items'].count > 0).to be_truthy
      expect(response.status).to be(200)
    end

    it 'should retun team_members with holiday false' do
      user.teams << team
      user.skills << skill
      user.user_projects.create(
        user_id: user.id,
        project_id: project.id,
        end_date: Date.today
      )
      FactoryBot.create(:holiday, user_id: user.id)

      get :index, params: { holidays: false }
      body = JSON.parse(response.body)
      expect(body['items'].present?).to be_falsey
      expect(body['items'].count).to be(0)
      expect(response.status).to be(200)
    end

    it 'should retun team_members with holiday true' do
      user.teams << team
      user.skills << skill
      user.user_projects.create(
        user_id: user.id,
        project_id: project.id,
        end_date: Date.today
      )
      FactoryBot.create(:holiday, user_id: user.id)

      get :index, params: { holiday: true }
      body = JSON.parse(response.body)
      expect(body['items'].present?).to be_truthy
      expect(body['items'].count > 0).to be_truthy
      expect(response.status).to be(200)
    end
  end
end
