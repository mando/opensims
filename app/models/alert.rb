class Alert < ActiveRecord::Base
  belongs_to :source_host, :class_name => "Host", :foreign_key => 'source_host_id'
  belongs_to :destination_host, :class_name => "Host", :foreign_key => 'dest_host_id'
end
