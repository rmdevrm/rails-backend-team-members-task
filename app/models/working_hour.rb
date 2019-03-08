# frozen_string_literal: true

class WorkingHour < ApplicationRecord
  belongs_to :user

  # mehtod to convert timestamp to minutes
  def self.time_in_minutes(time)
    hours, minutes = time.split(':').map(&:to_i)
    hours * 60 + minutes
  end

  # mehtod to convert stri to minutes
  def self.time_in_minutes_hour(minutes)
    (minutes / 60).to_s + ':' + (minutes % 60).to_s
  end

  def in_time
    WorkingHour.time_in_minutes(Time.zone.now.strftime('%H:%M')) >= start_time_in_minutes_utc && WorkingHour.time_in_minutes(Time.zone.now.strftime('%H:%M')) <= end_time_in_minutes_utc
  end
end
