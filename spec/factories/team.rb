# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Name.first_name }
  end
end
