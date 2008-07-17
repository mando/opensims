class SnortRuleTypesController < ApplicationController
  # GET /snort_rule_types
  # GET /snort_rule_types.xml
  def index
    @snort_rule_types = SnortRuleType.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @snort_rule_types }
    end
  end

  # GET /snort_rule_types/1
  # GET /snort_rule_types/1.xml
  def show
    @snort_rule_type = SnortRuleType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @snort_rule_type }
    end
  end

  # GET /snort_rule_types/new
  # GET /snort_rule_types/new.xml
  def new
    @snort_rule_type = SnortRuleType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @snort_rule_type }
    end
  end

  # GET /snort_rule_types/1/edit
  def edit
    @snort_rule_type = SnortRuleType.find(params[:id])
  end

  # POST /snort_rule_types
  # POST /snort_rule_types.xml
  def create
    @snort_rule_type = SnortRuleType.new(params[:snort_rule_type])

    respond_to do |format|
      if @snort_rule_type.save
        flash[:notice] = 'SnortRuleType was successfully created.'
        format.html { redirect_to(@snort_rule_type) }
        format.xml  { render :xml => @snort_rule_type, :status => :created, :location => @snort_rule_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @snort_rule_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /snort_rule_types/1
  # PUT /snort_rule_types/1.xml
  def update
    @snort_rule_type = SnortRuleType.find(params[:id])

    respond_to do |format|
      if @snort_rule_type.update_attributes(params[:snort_rule_type])
        flash[:notice] = 'SnortRuleType was successfully updated.'
        format.html { redirect_to(@snort_rule_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @snort_rule_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /snort_rule_types/1
  # DELETE /snort_rule_types/1.xml
  def destroy
    @snort_rule_type = SnortRuleType.find(params[:id])
    @snort_rule_type.destroy

    respond_to do |format|
      format.html { redirect_to(snort_rule_types_url) }
      format.xml  { head :ok }
    end
  end
end
