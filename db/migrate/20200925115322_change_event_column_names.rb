class ChangeEventColumnNames < ActiveRecord::Migration[6.0]
  def change
    change_table :events do |t|
      t.rename :event_date, :start
    end
  end
end
