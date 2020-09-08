class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
    	t.integer :company_id ,null:false
      t.string :name ,null:false
      t.string :description
      t.timestamps
    end
  end
end
