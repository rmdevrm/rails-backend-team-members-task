class WorkingHourSerializer < ActiveModel::Serializer
  attributes :timezone, :start, :end
end
