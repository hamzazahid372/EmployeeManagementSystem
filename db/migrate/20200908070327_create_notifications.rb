class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
    	t.integer :company_id, null:false
    	t.string :title , null:false
    	t.string :description
    	t.boolean :sent		# confusion

    	
      t.timestamps
    end
  end
end
