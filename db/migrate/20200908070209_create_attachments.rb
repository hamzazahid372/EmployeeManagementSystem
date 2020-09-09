# frozen_string_literal: true

# Attachment Migration
class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.integer :company_id, null: false, index: true
      t.integer :attachable_id, null: false
      t.string :attachable_type, null: false
      add_index(:attachments, %i[attachable_id attachable_type])
      t.timestamps
    end
  end
end
