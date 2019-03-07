# frozen_string_literal: true

FactoryBot.define do
  factory :holiday do
    start_date { Date.today }
    end_date { Date.today }
    user_id { FactoryBot.create(:user).id }
  end
end
