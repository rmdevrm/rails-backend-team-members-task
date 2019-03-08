# frozen_string_literal: true

class TeamMemberSerializer < ActiveModel::Serializer
  attributes :id,
             :skills,
             :first_name,
             :last_name,
             :working_hour,
             :on_holidays_till,
             :manager_id,
             :free_since,
             :current_project,
             :holiday

  attributes :current_project

  def skills
    object.skills.pluck(:name)
  end

  def current_project
    project = object.current_project

    return nil if project.blank?

    ActiveModelSerializers::SerializableResource.new(
      project,
      each_serializer: ProjectSerializer
    )
  end

  def working_hour
    return false if object.on_leave_today?
    return false if object.current_project.blank?

    object.working_hour.in_time
  end

  def on_holidays_till
    object.holidays.where('start_date <= ? AND end_date >= ?',
                          Date.today.beginning_of_day, Date.today.end_of_day)&.first&.end_date
  end

  def manager_id
    UserSerializer.new(object.manager).serializable_hash if object.manager
  end

  def holiday
    on_holidays_till.present?
  end
end
