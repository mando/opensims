class AlertsController < ApplicationController
  # GET /alerts
  # GET /alerts.xml
  def index
    @alerts = Alert.find(:all, :conditions => ['created_at >= ?', 1.minute.ago.to_s(:db)], :limit => 10, :include => [ { :source_host => :city }, { :destination_host => :city }] )

    source_hosts      = @alerts.collect { |a| a.source_host }
    destination_hosts = @alerts.collect { |a| a.destination_host } 
  
    # Fortunately, these will always line up since city will always be undef for both or neither
    # There's got to be a better way: FIXME 
    latitudes  = source_hosts.collect { |h| h.city.lat if !h.city.nil? }.compact.sort
    longitudes = source_hosts.collect { |h| h.city.long if !h.city.nil? }.compact.sort

    @map = GMap.new("map_div")
    @map.control_init(:large_map => true,:map_type => true)
    if (latitudes.count > 0)  
      @map.center_zoom_on_bounds_init([
        [latitudes.first, longitudes.first], 
        [latitudes.last,  longitudes.last]])
    else 
      @map.center_zoom_init([40.713956, -0.156250],2)
    end  
    #@map.overlay_init(GMarker.new([75.6,-42.467],:title => "Hello", :info_window => "Info! Info!"))
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alerts }
      format.json { render :text => @alerts.to_json }
    end
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
