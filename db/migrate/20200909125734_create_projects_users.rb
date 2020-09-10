class CreateProjectsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :projects_users do |t|
      t.integer :company_id, null: false, index: true
      t.integer :user_id, null: false, index: true
      t.integer :project_id, null: false, index: true
      t.timestamps
    end
  end
end
