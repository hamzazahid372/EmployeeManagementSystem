class AddUserIdToAttachment < ActiveRecord::Migration[6.0]
  def change
    add_column :attachments, :user_id, :integer, index: true
  end
end
