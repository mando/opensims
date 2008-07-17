class CreateAlerts < ActiveRecord::Migration
  def self.up
    create_table :alerts do |t|
      t.integer :source_host_id
      t.integer :source_host_port
      t.integer :dest_host_id
      t.integer :dest_host_port
      t.timestamp :alert_time
      t.integer :reporting_host_id
      t.integer :agent_id
      t.integer :snort_rule_id

      t.timestamps
    end
  end

  def self.down
    drop_table :alerts
  end
end
