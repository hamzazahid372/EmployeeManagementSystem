# frozen_string_literal: true

# Company Migration
class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :status, null: false
      t.string :name, null: false
      t.string :subdomain, null: false, uniqueness: true
      t.integer :owner_id, null: false, index: true
      t.timestamps
    end
  end
end
