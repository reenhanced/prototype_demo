class CreateCallLogs < ActiveRecord::Migration
  def self.up
    create_table :call_logs do |t|
      t.references :family_card
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :call_logs
  end
end
