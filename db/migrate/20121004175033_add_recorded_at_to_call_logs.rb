class AddRecordedAtToCallLogs < ActiveRecord::Migration
  def change
    add_column :call_logs, :recorded_at, :datetime
  end
end
