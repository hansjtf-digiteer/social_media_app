class CreateAuditLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :audit_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action
      t.string :record_type
      t.integer :record_id
      t.json :details

      t.timestamps
    end
  end
end