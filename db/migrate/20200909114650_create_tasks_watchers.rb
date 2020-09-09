# frozen_string_literal: true

# TaskWatcher Migration
class CreateTasksWatchers < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks_watchers do |t|
      t.integer :company_id, null: false, index: true
      t.integer :task_id, null: false, index: true
      t.integer :watcher_id, null: false
      t.string :watcher_type, null: false
      add_index(:tasks_watchers, %i[watcher_id watcher_type])
      t.timestamps
    end
  end
end
