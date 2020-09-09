# frozen_string_literal: true

# Event Migration
class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :company_id, null: false, index: true
      t.datetime :event_date, null: false
      t.string :title, null: false
      t.text :description
      t.integer :created_by_id, null: false, index: true
      t.timestamps
    end
  end
end
