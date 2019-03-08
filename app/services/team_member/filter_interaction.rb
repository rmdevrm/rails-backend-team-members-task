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
    return unless filters[:skills].present?

    @user_relation = @user_relation.where(
      'LOWER(skills.name) IN (?)',
      filters[:skills].split(',').map(&:strip).map(&:downcase)
    )
  end

  def project_filter
    return unless filters[:project].present?

    @user_relation = @user_relation.where('user_projects.project_id = ?',
                                          filters[:project])
  end

  def holiday_filter
    return unless filters[:holidays].to_s.present?

    @user_relation = if filters[:holidays].to_s == 'true'
                       @user_relation.joins(:holidays)
                                     .where(
                                       'holidays.start_date <= ? AND holidays.end_date >= ?',
                                       Date.today.beginning_of_day,
                                       Date.today.end_of_day
                                     )
                     else
                       @user_relation.joins(:holidays)
                                     .where.not(
                                       'holidays.start_date >=? AND holidays.end_date <= ?',
                                       Date.today.beginning_of_day,
                                       Date.today.end_of_day
                                     )
                     end
  end

  def first_name_filter
    return unless filters[:first_name].present?

    @user_relation = @user_relation.where(first_name: filters[:first_name])
  end

  def last_name_filter
    return unless filters[:last_name].present?

    @user_relation = @user_relation.where(first_name: filters[:last_name])
  end

  def working_hour_filter
    return unless filters[:working_hour].to_s.present?

    @user_relation = if filters[:working_hour].to_s == 'true'

                       @user_relation = @user_relation.joins(:holidays)
                                                      .where.not(
                                                        'holidays.start_date <= ? AND holidays.end_date >= ?',
                                                        Date.today.beginning_of_day,
                                                        Date.today.end_of_day
                                                      )
                                                      .where(
                                                        'working_hours.start_time_in_minutes_utc <= ? AND working_hours.end_time_in_minutes_utc > ? ',
                                                        WorkingHour.time_in_minutes(Time.zone.now.strftime('%H:%M')),
                                                        WorkingHour.time_in_minutes(Time.zone.now.strftime('%H:%M'))
                                                      )
    end
  end
end
