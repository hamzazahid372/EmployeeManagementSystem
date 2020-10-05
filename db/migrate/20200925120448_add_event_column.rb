class AddEventColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :end, :datetime
  end
end
