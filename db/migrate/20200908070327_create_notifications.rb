# frozen_string_literal: true

# Notification Migration
class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :company_id, null: false, index: true
      t.string :title, null: false
      t.text :description
      t.boolean :read, null: false, default: false
      t.timestamps
    end
  end
end
