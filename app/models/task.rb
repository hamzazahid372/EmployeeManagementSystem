# frozen_string_literal: true

# Task model
class Task < ApplicationRecord
  belongs_to :company
  #belongs_to :project
  belongs_to :project, foreign_key: 'parent_id'
  belongs_to :reviewer, class_name: 'User'
  belongs_to :watcher, polymorphic: true
  belongs_to :assignable, polymorphic: true
  belongs_to :created_by, class_name: 'User'
  has_many :comments, as: :commentable
  has_many :time_logs
  has_many :attachments, as: :attachable
  has_many :tasks_watchers
  has_many :watchers, through: :tasks_watchers, class_name: 'TasksWatcher'
  belongs_to :parent, class_name: 'Task'
end
