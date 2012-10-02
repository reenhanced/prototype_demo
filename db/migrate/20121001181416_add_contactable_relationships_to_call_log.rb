class AddContactableRelationshipsToCallLog < ActiveRecord::Migration
  def change
    add_column :call_logs, :contact_id, :integer
    add_column :call_logs, :contact_type, :string
  end
end
