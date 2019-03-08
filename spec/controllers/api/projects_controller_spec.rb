# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::ProjectsController, type: :controller do
  let(:project) { FactoryBot.create(:project) }
  let(:project1) { FactoryBot.create(:project) }

  describe 'GET :autocomplete' do
    it 'should retun projects' do
      get :autocomplete, params: { projects: project.name }
      expect(JSON.parse(response.body).present?).to be_truthy
      expect(response.status).to be(200)
    end

    it 'should not retun projects' do
      get :autocomplete, params: { projects: 'rails' }
      expect(JSON.parse(response.body).present?).to be_falsey
      expect(response.status).to be(200)
    end
  end

  describe 'GET :assign_user' do
    it 'should assign_user to project' do
      get :assign_user, params: { id: project.id, user_id: FactoryBot.create(:user).id }
      expect(JSON.parse(response.body).present?).to be_truthy
      expect(response.status).to be(200)
    end
  end
end
