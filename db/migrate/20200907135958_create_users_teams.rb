class CreateUsersTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :users_teams do |t|

      t.timestamps
    end
  end
end
