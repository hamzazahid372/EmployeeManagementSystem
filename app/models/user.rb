# frozen_string_literal: true

# Users model
class User < ApplicationRecord
  has_one :owned_company, class_name: 'Company'
  belongs_to :company
  belongs_to :department
  belongs_to :team
  has_many :users_team, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :created_projects, class_name: 'Project', dependent: :destroy, foreign_key: 'created_by_id'
  has_many :attendances, dependent: :destroy
  has_many :time_logs, dependent: :destroy
  has_many :created_events, class_name: 'Event', dependent: :destroy, foreign_key: 'created_by_id'
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :assigned_tasks, as: :assignable, dependent: :destroy
  has_many :created_tasks, class_name: 'Task', dependent: :destroy, foreign_key: 'created_by_id'
  has_many :created_teams, class_name: 'Team', dependent: :destroy, foreign_key: 'created_by_id'
  has_many :leading_teams, class_name: 'Team', dependent: :destroy, foreign_key: 'lead_id'
  has_many :reviewing_tasks, class_name: 'Task', dependent: :destroy, foreign_key: 'reviewer_id'
  has_many :tasks_watchers, as: :watcher, dependent: :destroy
  has_many :watching_tasks, through: :tasks_watchers, source: :task
  has_many :projects_users, dependent: :destroy
  has_many :projects, through: :projects_users
end
