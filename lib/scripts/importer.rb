#!/usr/bin/env /Users/mando/Projects/opensims2/scratch/script/runner
require 'geoip_city'
g = GeoIPCity::Database.new(RAILS_ROOT + '/lib/GeoLiteCity.dat')

File.open("data/alerts").each do |line|
  line.scan(/^(.*?)\s\s\[\*\*\]\s\[.*?\]\s\s\<.*?\>\s(.*?)\s\[.*?\]\s\[.*?\]\s\[.*?\]\s\{(.*?)\}\s(.*?)\:(.*?)\s\-\>\s(.*?)\:(.*?)$/) do |time, desc, transport, src_ip, src_port, dest_ip, dest_port|

    agent    = Agent.find_or_create_by_key( :key => "TESTKEY" )
    reporter = Host.find_or_create_by_ip_address( :ip_address => "127.0.0.1" )
    source   = Host.find_or_create_by_ip_address( :ip_address => src_ip )
    dest     = Host.find_or_create_by_ip_address( :ip_address => dest_ip )
    rule     = SnortRule.find_or_create_by_description( :description => desc )
   
    [src_ip, dest_ip].each do |ip| 
      geo = g.look_up(ip)
      
      country = Country.find_or_create_by_code(geo[:country_code])
      
      country.name   = geo[:country_name]
      country.code3  = geo[:country_code3]
      country.save
      
      if geo[:city]
        city = City.find_or_create_by_name(geo[:city])
        
        city.country_id = country.id
        city.lat        = geo[:latitude]
        city.long       = geo[:longitude]
        city.save

        if ip == src_ip
          source.city_id = city.id
          source.save
        else 
          dest.city_id = city.id
          dest.save  
        end     
      
      end
    
    end

    a = Alert.create(
      :source_host_id     => source.id,
      :source_host_port   => src_port,
      :dest_host_id       => dest.id,
      :dest_host_port     => dest_port,
      :alert_time         => time,
      :reporting_host_id  => reporter.id,
      :agent_id           => agent.id,
      :snort_rule_id      => rule.id
    )
    
    puts "TIME: #{time} DESC: #{desc} TRANSPORT: #{transport} SRC_IP: #{src_ip} SRC_PORT: #{src_port} DEST_IP: #{dest_ip} DEST_PORT: #{dest_port}"
  end
end 
