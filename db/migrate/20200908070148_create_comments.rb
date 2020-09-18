# frozen_string_literal: true

# Comment Migration
class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :company_id, null: false, index: true
      t.integer :commentable_id, null: false
      t.string :commentable_type, null: false
      t.integer :user_id
      t.text :content
      t.timestamps
    end
    add_index(:comments, %i[commentable_id commentable_type])
  end
end
