# frozen_string_literal: true

class WorkingHourSerializer < ActiveModel::Serializer
  attributes :timezone, :start_time, :end_time
end
