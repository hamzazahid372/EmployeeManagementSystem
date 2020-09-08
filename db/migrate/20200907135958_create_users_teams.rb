class CreateUsersTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :users_teams do |t|
      t.integer :team_id, null: false
      t.integer :user_id, null: false
      t.integer :company_id, null: false
      t.timestamps
    end
  end
end
