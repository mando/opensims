class CreateSnortRuleTypes < ActiveRecord::Migration
  def self.up
    create_table :snort_rule_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :snort_rule_types
  end
end
