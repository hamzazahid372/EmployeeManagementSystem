# frozen_string_literal: true

# Department Migration
class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.integer :company_id, null: false, index: true
      t.string :name, null: false
      t.text :description
      t.timestamps
    end
  end
end
