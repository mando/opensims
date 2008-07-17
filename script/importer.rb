#!/usr/bin/env ruby

require "rubygems"
require "yaml"
require "activerecord"
require "../app/models/host.rb"
require "../app/models/alert.rb"
require "../app/models/agent.rb"

ActiveRecord::Base.establish_connection(
    :adapter        => :postgresql,
    :database       => "league_dev",
    :username       => "mando",
    :password       => "",
    :host           => "localhost"
)

File.open("data/alerts").each do |line|
  line.scan(/^(.*?)\s\s\[\*\*\]\s\[.*?\]\s\s\<.*?\>\s(.*?)\s\[.*?\]\s\[.*?\]\s\[.*?\]\s\{(.*?)\}\s(.*?)\:(.*?)\s\-\>\s(.*?)\:(.*?)$/) do |time, desc, transport, src_ip, src_port, dest_ip, dest_port|

    h = Host.find_or_create_by_ip_address( :ip_address => "127.0.0.1" )
    h.  
    puts "TIME: #{time} DESC: #{desc} TRANSPORT: #{transport} SRC_IP: #{src_ip} SRC_PORT: #{src_port} DEST_IP: #{dest_ip} DEST_PORT: #{dest_port}"
  end
end 
