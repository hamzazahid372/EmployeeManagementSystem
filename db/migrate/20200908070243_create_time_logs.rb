# frozen_string_literal: true

# Time-Log Migration
class CreateTimeLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :time_logs do |t|
      t.integer :task_id, index: true
      t.integer :company_id, null: false, index: true
      t.integer :user_id, null: false, index: true
      t.decimal :hours, precision: 5, scale: 2
      t.timestamps
    end
  end
end
