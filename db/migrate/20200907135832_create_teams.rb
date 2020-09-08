class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|

			t.string :name, null:false
			t.string :description
      t.integer :company_id , null:false
      t.integer :lead_id ,null:false
      t.integer :sequence_number , null:false
      t.timestamps
    end
  end
end
