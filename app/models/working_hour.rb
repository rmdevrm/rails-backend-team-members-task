# frozen_string_literal: true

class WorkingHour < ApplicationRecord
  belongs_to :user

  def self.time_in_minutes(time)
    hours, minutes = time.split(':').map(&:to_i)
    hours * 60 + minutes
  end

  def self.time_in_minutes_hour(minutes)
    (minutes / 60).to_s + ':' + (minutes % 60).to_s
  end
end
