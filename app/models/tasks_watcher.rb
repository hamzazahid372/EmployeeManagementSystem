# frozen_string_literal: true

# Tasks Watcher model
class TasksWatcher < ApplicationRecord
  belongs_to :company
  belongs_to :task
  belongs_to :watcher, polymorphic: true
  validates :task_id, uniqueness: { scope: %i[watcher_id watcher_type] }
end
