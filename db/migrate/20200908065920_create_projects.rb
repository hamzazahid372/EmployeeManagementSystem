class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name , null:false
      t.integer :company_id , null:false
      t.string :description
      t.string :status
      t.datetime :start_date , null:false
      t.datetime :end_date , null:false
      t.datetime :expected_start_date , null:false
      t.datetime :expected_end_date , null:false
      t.datetime :created_by_id , null:false
      t.timestamps
    end
  end
end
