class CreateWorkingDays < ActiveRecord::Migration[6.0]
  def change
    create_table :working_days do |t|
      t.integer :company_id, null: false, index: true
      t.time :from
      t.time :to
      t.string :day
      t.boolean :off_day
      t.timestamps
    end
  end
end
