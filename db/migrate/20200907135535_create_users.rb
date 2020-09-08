class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name, null:false
      t.string :last_name, null:false
      t.string :email, null:false, uniqueness:true
      t.integer :role_id , null:false
      t.integer :company_id ,null:false
      t.integer :sequence_number , null:false
      t.integer :department_id , null:false
      t.boolean :active
      t.timestamps
    end
  end
end
