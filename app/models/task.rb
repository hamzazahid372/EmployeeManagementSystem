# frozen_string_literal: true

# Task model
class Task < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :reviewer, class_name: 'User'
  belongs_to :assignable, polymorphic: true
  belongs_to :created_by, class_name: 'User'
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :time_logs, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :tasks_watchers, dependent: :destroy
  has_many :watcher_users, through: :tasks_watchers, source: :watcher, source_type: 'User'
  has_many :watcher_teams, through: :tasks_watchers, source: :watcher, source_type: 'Team'
  has_many :childs, foreign_key: 'parent_id', class_name: 'Task'
end
