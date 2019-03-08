# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# skill creation
[
  'Javascript',
  'Rails',
  'React',
  'Vue',
  'Java',
  'Angular',
  'Redux',
  'Node',
  'Ethereum',
  'Solidity',
  'React-Nativ'
].each do |name|
  Skill.create(name: name)
end

# Creattion of manager
manager = User.create(
  first_name: 'Manager',
  last_name: 'User',
  email: 'manager@yopmail.com'
)

# Creation of Users
(0..20).each do |_i|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email
  )
end

users = User.all

# Creation of projects
(0..20).each do |_i|
  Project.create(
    name: Faker::Company.name
  )
end

# Creation of Team
Team.create(name: 'developer')

# Working Hours
shift = [
  {
    start_time: (Time.zone.now - 1.hour).strftime('%H:%M'),
    end_time: (Time.zone.now + 9.hour).strftime('%H:%M')
  },
  {
    start_time: (Time.zone.now - 4.hour).strftime('%H:%M'),
    end_time: (Time.zone.now + 9.hour).strftime('%H:%M')
  },
  {
    start_time: (Time.zone.now - 2.hour).strftime('%H:%M'),
    end_time: (Time.zone.now + 9.hour).strftime('%H:%M')
  }
]

# Creation of working_hour
users.each do |user|
  random_shift = shift.sample
  working_hour = user.build_working_hour(
    start_time_in_minutes_utc: WorkingHour.time_in_minutes(random_shift[:start_time]),
    end_time_in_minutes_utc: WorkingHour.time_in_minutes(random_shift[:end_time]),
    timezone: 'utc'
  )
  working_hour.save
end

# assign skills to user
skills = Skill.all
users.each do |user|
  random_skill = skills.sample
  user.skills << random_skill
end

# assignment of projects to user
projects = Project.all
end_dates = [Date.today + 1.day, Date.today - 2.day, Date.today]
users.each do |user|
  random_project = projects.sample
  random_date = end_dates.sample
  user.user_projects.create(
    project_id: random_project.id,
    end_date: random_date
  )
end

# Cration of holidays
holidays = [
  { start_date: Date.today, end_date: Date.today },
  { start_date: Date.today, end_date: Date.today + 1 },
  { start_date: Date.today + 1, end_date: Date.today + 2 }
]

User.first(5).each do |user|
  random_holiday = holidays.sample
  user.holidays.create(
    start_date: random_holiday[:start_date],
    end_date: random_holiday[:end_date]
  )
end

# assign Team to users

Team.first.users << users

User.all.each do |user|
  user.update(manager_id: manager.id)
end
