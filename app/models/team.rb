# frozen_string_literal: true

# Team model
class Team < ApplicationRecord
  belongs_to :lead, class_name: 'User'
  belongs_to :company
  has_many :users_team
  has_many :users, through: :users_team
  has_many :assigned_tasks, class_name: 'Task', as: :assignable
  has_many :tasks_watchers, as: :watcher
  has_many :tasks, through: :tasks_watchers
end
