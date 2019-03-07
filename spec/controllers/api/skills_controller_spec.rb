# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::SkillsController, type: :controller do
  let(:skill) { FactoryBot.create(:skill) }
  let(:skill1) { FactoryBot.create(:skill) }

  describe 'GET :autocomplete' do
    it 'should retun skills' do
      get :autocomplete, params: { skills: skill.name }
      expect(JSON.parse(response.body).present?).to be_truthy
      expect(response.status).to be(200)
    end

    it 'should not retun skills' do
      get :autocomplete, params: { skills: 'rails' }
      expect(JSON.parse(response.body).present?).to be_falsey
      expect(response.status).to be(200)
    end
  end
end
