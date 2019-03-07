# frozen_string_literal: true

class TeamMember::FilterInteraction < ActiveInteraction::Base
  object :team
  hash :filters, strip: false

  def execute
    @user_relation = User.joins(:teams,
                                :skills,
                                :projects,
                                :working_hour).distinct.where(
                                  'user_teams.team_id = ?', team.id
                                )
    skill_filter
    project_filter
    holiday_filter
    working_hour_filter
    first_name_filter
    last_name_filter
    @user_relation
  end

  def skill_filter
    return unless filters[:skill].present?

    @user_relation = @user_relation.where(skills: { name: filters[:skill] })
  end

  def project_filter
    return unless filters[:project].present?

    @user_relation = @user_relation.where('user_projects.project_id = ?',
                                          filters[:project])
  end

  def holiday_filter
    return unless filters[:holidays].present?

    @user_relation = @user_relation.joins(:holidays)
                                   .where(
                                     'holidays.start_date => ? OR holidays.end_date <= ?',
                                     Date.today,
                                     Date.today
                                   )
  end

  def first_name_filter
    return unless first_name.present?

    @user_relation = @user_relation.where(first_name: first_name)
  end

  def last_name_filter
    return unless first_name.present?

    @user_relation = @user_relation.where(first_name: last_name)
  end

  def working_hour_filter
    return unless filters[:working_hour].present?

    @user_relation = @user_relation.where(
      'working_hours.start_time_in_minutes <= ? AND working_hours.end_time_in_minutes > ? ',
      WorkingHour.time_in_minutes(Time.zone.now.to_utc.strftime('%H:%M')),
      WorkingHour.time_in_minutes(Time.zone.now.to_utc.strftime('%H:%M'))
    )
  end
end
