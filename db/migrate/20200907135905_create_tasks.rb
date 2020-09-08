class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.integer :company_id , null:false
      t.string :title , null:false
      t.string :description
      t.integer :assigned_to_id , null:false
      t.integer :assigned_to_type , null:false
      t.integer :created_by_id , null:false
      t.string :status , default: "Assigned"
      t.datetime :due_date
      t.integer :project_id , null:false
      t.integer :reviewer_id 
      t.integer :watcher_id 
      t.datetime :started_at ,null:false
      t.datetime :completed_at 
      t.integer :progress #in percentage
      t.datetime :expected_end_date ,null:false
      t.datetime :expected_start_date ,null:false
      t.integer :priority
      t.timestamps
    end
  end
end
