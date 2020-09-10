# frozen_string_literal: true

# Task Migration
class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.integer :company_id, null: false
      t.string :title, null: false
      t.text :description
      t.integer :assignable_id
      t.string :assignable_type
      t.integer :created_by_id, null: false, index: true
      t.string :status, null: false
      t.datetime :due_date
      t.integer :project_id, null: false, index: true
      t.integer :reviewer_id, index: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer :progress # in percentage
      t.datetime :expected_end_date
      t.datetime :expected_start_date
      t.integer :priority, null: false
      t.references :parent
      t.timestamps
    end
    add_index(:tasks, %i[assignable_id assignable_type])
  end
end
