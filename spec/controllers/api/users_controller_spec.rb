# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::UsersController, type: :controller do
  let(:user) { FactoryBot.build(:user) }
  describe 'GET :index' do
    it 'should retun users' do
      FactoryBot.create(:user)
      get :index
      expect(JSON.parse(response.body).present?).to be_truthy
      expect(response.status).to be(200)
    end

    it 'should not retun skills' do
      get :index
      expect(JSON.parse(response.body).present?).to be_falsey
      expect(response.status).to be(200)
    end
  end

  describe 'POST :create' do
    it 'should create user' do
      get :create, params: { user: user.attributes }
      expect(JSON.parse(response.body).present?).to be_truthy
      expect(response.status).to be(200)
    end

    it 'should not create user when first_name is nil' do
      get :create, params: { user: { first_name: nil,
                                     last_name: Faker::Name.last_name,
                                     email: Faker::Internet.email } }
      expect(response.status).to be(422)
    end

    it 'should not create user when last_name is nil' do
      get :create, params: { user: { last_name: nil,
                                     first_name: Faker::Name.last_name,
                                     email: Faker::Internet.email } }
      expect(response.status).to be(422)
    end

    it 'should not create user when email is nil' do
      get :create, params: { user: { last_name: nil,
                                     first_name: Faker::Name.last_name,
                                     email: nil } }
      expect(response.status).to be(422)
    end
  end

  describe 'GET :show' do
    it 'should return user with valid user_id' do
      user = FactoryBot.create(:user)
      get :show, params: { id: user.id }
      expect(JSON.parse(response.body).present?).to be_truthy
      expect(response.status).to be(200)
    end

    it 'should not return user with in_valid user_id' do
      get :show, params: { id: 'ddd' }
      expect(response.status).to be(404)
    end
  end

  describe 'PUT :update' do
    it 'should delete user with valid id' do
      user = FactoryBot.create(:user)
      first_name = 'tester'
      get :update, params: { id: user.id, user: { first_name: first_name } }
      body = JSON.parse(response.body)
      expect(body['first_name']).to eq(first_name)
      expect(response.status).to be(200)
    end

    it 'should not update user with invalid user_id' do
      get :update, params: { id: 'ddd' }
      expect(response.status).to be(404)
    end
  end

  describe 'PUT :delete' do
    it 'should delete user with valid id' do
      user = FactoryBot.create(:user)
      get :destroy, params: { id: user.id }
      expect(JSON.parse(response.body).present?).to be_truthy
      expect(response.status).to be(200)
    end

    it 'should not delete user with invalid user_id' do
      get :destroy, params: { id: 'ddd' }
      expect(response.status).to be(404)
    end
  end
end
