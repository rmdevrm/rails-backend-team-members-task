# frozen_string_literal: true

FactoryBot.define do
  factory :working_hour do
    start_time_in_minutes_utc { WorkingHour.time_in_minutes('10:00') }
    end_time_in_minutes_utc { WorkingHour.time_in_minutes('19:00') }
  end
end
