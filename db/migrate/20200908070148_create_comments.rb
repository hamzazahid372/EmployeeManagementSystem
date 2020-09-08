class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
    	t.integer :company_id , null:false
    	t.integer :commentable_id , null:false
    	t.integer :commentable_type , null:false
    	t.string :content
      t.timestamps
    end
  end
end
