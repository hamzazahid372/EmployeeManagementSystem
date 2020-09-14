# frozen_string_literal: true

# User Migration
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      # t.string :email, null: false, uniqueness: true
      t.integer :role_id, index: true
      t.integer :company_id, null: false, index: true
      t.integer :sequence_num, index: true
      t.integer :department_id, index: true
      t.boolean :active, null: false, default: true
      t.timestamps
    end
  end
end
