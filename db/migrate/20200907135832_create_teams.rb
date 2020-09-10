# frozen_string_literal: true

# Team Migration
class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.text :description
      t.integer :company_id, null: false, index: true
      t.integer :lead_id, null: false, index: true
      t.integer :sequence_num, null: false
      t.integer :created_by_id, index: true
      t.timestamps
    end
  end
end
