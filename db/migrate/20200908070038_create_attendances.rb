class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
    	t.integer :company_id , null:false
			t.integer :user_id , null:false
			t.datetime :login_time
			t.datetime :logout_time
			t.boolean :present
      t.timestamps
    end
  end
end
