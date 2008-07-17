class CreateSnortRules < ActiveRecord::Migration
  def self.up
    create_table :snort_rules do |t|
      t.string :description
      t.integer :snortruletype_id

      t.timestamps
    end
  end

  def self.down
    drop_table :snort_rules
  end
end
