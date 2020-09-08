class CreateProjectsDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :projects_departments do |t|
      
    	t.integer :company_id , null:false
 			t.integer :project_id , null:false
 			t.integer :department_id , null:false
      t.timestamps
    end
  end
end
