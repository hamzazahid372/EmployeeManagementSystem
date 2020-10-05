class AddSequenceNumToEvents < ActiveRecord::Migration[6.0]


  def self.up
    add_column :events, :sequence_num, :integer, null: false
    update_sequence_num_values
    add_index :events, [:sequence_num,:company_id], unique: true
  end

  def self.down
    remove_index  :events, column: [:sequence_num, :company_id]
    remove_column :events, :sequence_num
  end

  def self.update_sequence_num_values
    Company.all.each do |parent|
      cntr = 1
      parent.events.reorder("id").all.each do |nested|
        nested.sequence_num = cntr
        cntr += 1
        nested.save
      end
    end
  end
end

