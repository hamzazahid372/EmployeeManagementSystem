class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
			t.integer :company_id , null:false
    	t.datetime :event_date , null:false
    	t.string :title , null:false
    	t.string :description
    	t.integer :created_by_id , null:false
    	
    	
      t.timestamps
    end
  end
end
