# frozen_string_literal: true

# Project Migration
class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.integer :company_id, null: false, index: true
      t.text :description
      t.string :status, null: false
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :expected_start_date
      t.datetime :expected_end_date
      t.datetime :created_by_id, null: false
      t.timestamps
    end
  end
end
