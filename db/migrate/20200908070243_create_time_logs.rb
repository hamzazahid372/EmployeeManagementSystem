class CreateTimeLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :time_logs do |t|
      t.integer :task_id, null: false
      t.integer :company_id, null: false
      t.integer :user_id, null: false
      t.decimal :hours, precision: 5, scale: 3
      t.timestamps
    end
  end
end
