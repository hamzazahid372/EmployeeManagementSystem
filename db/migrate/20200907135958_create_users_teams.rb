# frozen_string_literal: true

# Team Migration
class CreateUsersTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :users_teams do |t|
      t.integer :team_id, null: false, index: true
      t.integer :user_id, null: false, index: true
      t.integer :company_id, null: false, index: true
      t.timestamps
    end
  end
end
