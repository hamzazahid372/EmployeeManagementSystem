class AddSequenceNumToAttachments < ActiveRecord::Migration[6.0]

  def self.up
    add_column :attachments, :sequence_num, :integer, null: false
    update_sequence_num_values
    add_index :attachments, [:sequence_num,:company_id], unique: true
  end

  def self.down
    remove_index  :attachments, column: [:sequence_num, :company_id]
    remove_column :attachments, :sequence_num
  end

  def self.update_sequence_num_values
    Company.all.each do |parent|
      count = 1
      parent.attachments.reorder("id").all.each do |attachment|
        attachment.sequence_num = count
        count += 1
        attachment.save
      end
    end
  end
end
