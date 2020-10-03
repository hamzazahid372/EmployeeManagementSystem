class AddAttachmentColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :attachments, :attachment_file_name, :string
    add_column :attachments, :attachment_content_type, :string
    add_column :attachments, :attachment_file_size, :float
    add_column :attachments, :attachment_updated_at, :datetime
  end
end
