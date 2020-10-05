class CreateHolidays < ActiveRecord::Migration[6.0]
  def change
    create_table :holidays do |t|
      t.integer :company_id, null: false, index: true
      t.date :day
      t.boolean :every_year
      t.timestamps
    end
  end
end
