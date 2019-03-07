class TeamMemberSerializer < ActiveModel::Serializer
  attributes :id, :skills, :first_name, :last_name, :id, :working_hours
  attributes :current_project

  def skills
    object.skills.pluck(:name)
  end

  def current_project
    ActiveModelSerializers::SerializableResource.new(object.projects, each_serializer: ProjectSerializer)
  end

  def working_hours
    ::WorkingHourSerializer.new(object.working_hour).serializable_hash
  end
end
