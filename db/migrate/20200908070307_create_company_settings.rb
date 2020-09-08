class CreateCompanySettings < ActiveRecord::Migration[6.0]
  def change
    create_table :company_settings do |t|
    	t.integer :company_id , null:false
    	
      t.timestamps
    end
  end
end
