# frozen_string_literal: true

# Attendance Migration
class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.integer :company_id, null: false, index: true
      t.integer :user_id, null: false, index: true
      t.datetime :login_time
      t.datetime :logout_time
      t.boolean :present, null: false, default: true
      t.timestamps
    end
  end
end
