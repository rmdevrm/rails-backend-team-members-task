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
             :current_project

  attributes :current_project

  def skills
    object.skills.pluck(:name)
  end

  def current_project
    project = object.current_project

    if project.present?
      ActiveModelSerializers::SerializableResource.new(
        project,
        each_serializer: ProjectSerializer
      )
    end
  end

  def working_hour
    return false if object.on_leave_today?
    return false if object.current_project.blank?

    object.working_hour('start_time::time < ? AND end_time::time > ? ',
                        Time.zone.now.strftime('%I:%M:%S'),
                        Time.zone.now.strftime('%I:%M:%S')).present?
  end

  def on_holidays_till
    object.holidays.where('start_date <= ? AND end_date >= ?',
                          Date.today, Date.today).first.end_date
  end

  def manager_id
    UserSerializer.new(object.manager).serializable_hash if object.manager
  end
end
