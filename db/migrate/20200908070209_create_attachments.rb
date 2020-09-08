class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
    	t.integer :company_id , null:false
      t.integer :attachable_id , null:false
      t.string :attachable_type , null:false
      t.timestamps
    end
  end
end
