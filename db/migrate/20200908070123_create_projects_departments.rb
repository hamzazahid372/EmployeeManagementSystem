# frozen_string_literal: true

# ProjectsDepartments Migration
class CreateProjectsDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :projects_departments do |t|
      t.integer :company_id, null: false, index: true
      t.integer :project_id, null: false, index: true
      t.integer :department_id, null: false, index: true
      t.timestamps
    end
    add_index(:projects_departments, %i[project_id department_id], unique: true)
  end
end
