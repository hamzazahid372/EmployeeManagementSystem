# frozen_string_literal: true

# Users model
class User < ApplicationRecord
  has_one :owned_company, class_name: 'Company'
  belongs_to :company
  belongs_to :department
  belongs_to :team
  has_many :users_team
  has_many :comments
  has_many :tasks
  has_many :created_projects, class_name: 'Project'
  has_many :attendances
  has_many :time_logs
  has_many :created_events, class_name: 'Event'
  has_many :attachments, as: :attachable
  has_many :tasks, as: :assignable
  has_many :assigned_tasks, class_name: 'Task'
  has_many :created_tasks, class_name: 'Task'
  has_many :created_teams, class_name: 'Team'
  has_many :leading_teams, class_name: 'Team'
  has_many :reviewing_tasks, class_name: 'Task'
  has_many :tasks_watchers, as: :watcher
  has_many :tasks, through: :tasks_watchers
  has_many :projects_users
  has_many :projects, through: :projects_users
end
