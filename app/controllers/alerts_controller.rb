class AlertsController < ApplicationController
  # GET /alerts
  # GET /alerts.xml
  
  def index
    @alerts = Alert.find(:all, :conditions => ['created_at >= ?', 100000.minutes.ago.to_s(:db)], :limit => 100, :include => [ { :source_host => :city }, { :destination_host => :city }] )

    latitudes   = Array.new
    longitudes  = Array.new
    markers     = Array.new
    lines       = Array.new

    @alerts.each do |a|
      next if a.source_host.city.nil? || a.destination_host.city.nil? # Just in case there's a missing city
      source_coords = [a.source_host.city.lat, a.source_host.city.long]
      dest_coords   = [a.destination_host.city.lat, a.destination_host.city.long]
	  source_country_name = a.source_host.city.country.name
	  dest_country_name = a.destination_host.city.country.name
      markers << GMarker.new([source_coords[0], source_coords[1]],:title=>a.source_host.city.name + "," + a.source_host.city.country.name,:info_window=>"Source:" + a.source_host.city.name + ", " + a.source_host.city.country.name + "<br/ >Lat: " + a.source_host.city.lat + ", Long:" + a.source_host.city.long)
      markers << GMarker.new([dest_coords[0], dest_coords[1]],:title=>a.destination_host.city.name + "," + a.destination_host.city.country.name,:info_window=>"Destination:" + a.destination_host.city.name + ", " + a.destination_host.city.country.name + "<br />Lat: " + a.destination_host.city.lat + ", Long:" + a.destination_host.city.long)
      latitudes << source_coords[0].to_d
      latitudes << dest_coords[0].to_d
      longitudes << source_coords[1].to_d
      longitudes << dest_coords[1].to_d
	  puts "source coords=" + source_coords[0] + "," + source_coords[1] + ", dest_coords=" + dest_coords[0] + "," + dest_coords[1]
	  if (source_coords[1].to_d > 100)
	  	# if the signs are the same, then it should be
		#  Diff = one - other
		# if different, then
		#  Diff = one.abs + other.abs
	  	latDiff = getDiff(source_coords[0].to_d,dest_coords[0].to_d)
		lngDiff = getDiff(source_coords[1].to_d,dest_coords[1].to_d)
		latMargin = latDiff/3
		lngMargin = lngDiff/3
		puts "lat margin=" + latMargin.to_s + ", Diff=" + latDiff.to_s
		puts "lng margin=" + lngMargin.to_s + ", Diff=" + lngDiff.to_s
		lines << GPolyline.new([source_coords,[source_coords[0].to_d - latMargin,source_coords[1].to_d - lngMargin]])
		lines << GPolyline.new([[source_coords[0].to_d - latMargin,source_coords[1].to_d - lngMargin],[source_coords[0].to_d - (2*latMargin),source_coords[1].to_d - (2*lngMargin)]])
		lines << GPolyline.new([[source_coords[0].to_d - (2*latMargin),source_coords[1].to_d - (2*lngMargin)],dest_coords])
      else
	  	lines << GPolyline.new([source_coords, dest_coords])
	  end
    end

    latitudes.sort!
    longitudes.sort!
    
    @map = GMap.new("map_div")
    @map.control_init(:large_map => true,:map_type => true)
    if (latitudes.count > 0)  
      @map.center_zoom_on_bounds_init([
        [latitudes.first, longitudes.first], 
        [latitudes.last,  longitudes.last]])
		puts "Centered on information : lat.first=" + latitudes.first.to_s + ", long.first=" + longitudes.first.to_s  + "--lat.last=" + latitudes.last.to_s + ", long.last=" + longitudes.last.to_s
    else 
      @map.center_zoom_init([40.713956, -0.156250],3)
		puts "Centered by default"
    end 

    markers.each do |m|
      @map.overlay_init(m)
    end

    lines.each do |l|
      @map.overlay_init(l)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alerts }
      format.json { render :text => @alerts.to_json }
    end
  end

  def getDiff(src,dest)
  	diff = 0
  	if (src < 0)
		if (dest < 0)
			# both are the same sign
			diff = src - dest
		else
			diff = src.abs + dest.abs
		end 
	end
  	if (src > 0)
		if (dest > 0)
			# both are the same sign
			diff = src - dest
		else
			diff = src.abs + dest.abs
		end 
	end
	return diff
  end

  # GET /alerts/1
  # GET /alerts/1.xml
  def show
    @alert = Alert.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @alert }
    end
  end

  # GET /alerts/new
  # GET /alerts/new.xml
  def new
    @alert = Alert.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @alert }
    end
  end

  # GET /alerts/1/edit
  def edit
    @alert = Alert.find(params[:id])
  end

  # POST /alerts
  # POST /alerts.xml
  def create
    @alert = Alert.new(params[:alert])

    respond_to do |format|
      if @alert.save
        flash[:notice] = 'Alert was successfully created.'
        format.html { redirect_to(@alert) }
        format.xml  { render :xml => @alert, :status => :created, :location => @alert }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @alert.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /alerts/1
  # PUT /alerts/1.xml
  def update
    @alert = Alert.find(params[:id])

    respond_to do |format|
      if @alert.update_attributes(params[:alert])
        flash[:notice] = 'Alert was successfully updated.'
        format.html { redirect_to(@alert) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @alert.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /alerts/1
  # DELETE /alerts/1.xml
  def destroy
    @alert = Alert.find(params[:id])
    @alert.destroy

    respond_to do |format|
      format.html { redirect_to(alerts_url) }
      format.xml  { head :ok }
    end
  end
end
