# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 7) do

  create_table "agents", :force => true do |t|
    t.string   "key"
    t.string   "industry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alert", :force => true do |t|
    t.string   "source",       :limit => 20,                  :null => false
    t.integer  "alert_def_id",                                :null => false
    t.integer  "src_host_id",                                 :null => false
    t.string   "src_port",     :limit => 6,  :default => "0", :null => false
    t.integer  "dst_host_id",                                 :null => false
    t.string   "dst_port",     :limit => 6,  :default => "0", :null => false
    t.string   "protocol",     :limit => 6,                   :null => false
    t.float    "ce",                         :default => 0.0, :null => false
    t.float    "te",                         :default => 0.0, :null => false
    t.float    "ve",                         :default => 0.0, :null => false
    t.float    "rm",                         :default => 0.0, :null => false
    t.float    "ci",                         :default => 0.0, :null => false
    t.datetime "created",                                     :null => false
    t.integer  "tick",                       :default => 0,   :null => false
  end

  add_index "alert", ["tick"], :name => "alert_i_timeout"

  create_table "alert_def", :force => true do |t|
    t.string   "unique_id",     :limit => 20, :null => false
    t.integer  "alert_type_id",               :null => false
    t.datetime "created",                     :null => false
    t.datetime "updated"
  end

  add_index "alert_def", ["unique_id"], :name => "alert_def_u_unique_id", :unique => true

  create_table "alert_type", :force => true do |t|
    t.string   "name",    :limit => 50, :null => false
    t.datetime "created",               :null => false
  end

  add_index "alert_type", ["name"], :name => "alert_type_u_name", :unique => true

  create_table "alerts", :force => true do |t|
    t.integer  "source_host_id"
    t.integer  "source_host_port"
    t.integer  "dest_host_id"
    t.integer  "dest_host_port"
    t.datetime "alert_time"
    t.integer  "reporting_host_id"
    t.integer  "agent_id"
    t.integer  "snort_rule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.string   "lat"
    t.string   "long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "code3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "host", :force => true do |t|
    t.string   "ip_addr", :limit => 16,                   :null => false
    t.datetime "created",                                 :null => false
    t.string   "network", :limit => 8
    t.string   "country", :limit => 4,  :default => "??"
    t.integer  "tick",                  :default => 0,    :null => false
    t.integer  "linger",                :default => 0,    :null => false
  end

  add_index "host", ["country", "ip_addr", "network"], :name => "host_i_report"
  add_index "host", ["linger", "network", "tick"], :name => "host_i_timeout"
  add_index "host", ["ip_addr"], :name => "host_u_ip_addr", :unique => true

  create_table "host_org_link", :id => false, :force => true do |t|
    t.integer "host_id"
    t.string  "organization", :limit => 40
  end

  create_table "hosts", :force => true do |t|
    t.string   "ip_address"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "id_table", :id => false, :force => true do |t|
    t.integer "id_table_id", :null => false
    t.string  "table_name",  :null => false
    t.integer "next_id"
    t.integer "quantity"
  end

  add_index "id_table", ["table_name"], :name => "id_table_u_1", :unique => true

  create_table "org", :primary_key => "org_name", :force => true do |t|
    t.string "org_desc", :limit => 80
  end

  create_table "response", :force => true do |t|
    t.integer  "host_id",                                :null => false
    t.datetime "created",                                :null => false
    t.integer  "tick",                    :default => 0, :null => false
    t.string   "action",    :limit => 20,                :null => false
    t.integer  "level",                   :default => 0, :null => false
    t.string   "file",      :limit => 50
    t.integer  "acquittal",               :default => 0, :null => false
    t.integer  "pending",                 :default => 0, :null => false
  end

  add_index "response", ["action", "file", "host_id", "tick"], :name => "response_i_report"
  add_index "response", ["acquittal", "host_id", "pending"], :name => "response_i_timeout"

  create_table "snort_rule_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "snort_rules", :force => true do |t|
    t.string   "description"
    t.integer  "snortruletype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", :primary_key => "user_name", :force => true do |t|
    t.string "role_name", :limit => 15, :null => false
  end

  create_table "users", :primary_key => "user_name", :force => true do |t|
    t.string "user_pass",    :limit => 15, :default => "bar",         :null => false
    t.string "organization", :limit => 40, :default => "admin_group", :null => false
  end

end
