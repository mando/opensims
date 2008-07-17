class SnortRulesController < ApplicationController
  # GET /snort_rules
  # GET /snort_rules.xml
  def index
    @snort_rules = SnortRule.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @snort_rules }
    end
  end

  # GET /snort_rules/1
  # GET /snort_rules/1.xml
  def show
    @snort_rule = SnortRule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @snort_rule }
    end
  end

  # GET /snort_rules/new
  # GET /snort_rules/new.xml
  def new
    @snort_rule = SnortRule.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @snort_rule }
    end
  end

  # GET /snort_rules/1/edit
  def edit
    @snort_rule = SnortRule.find(params[:id])
  end

  # POST /snort_rules
  # POST /snort_rules.xml
  def create
    @snort_rule = SnortRule.new(params[:snort_rule])

    respond_to do |format|
      if @snort_rule.save
        flash[:notice] = 'SnortRule was successfully created.'
        format.html { redirect_to(@snort_rule) }
        format.xml  { render :xml => @snort_rule, :status => :created, :location => @snort_rule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @snort_rule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /snort_rules/1
  # PUT /snort_rules/1.xml
  def update
    @snort_rule = SnortRule.find(params[:id])

    respond_to do |format|
      if @snort_rule.update_attributes(params[:snort_rule])
        flash[:notice] = 'SnortRule was successfully updated.'
        format.html { redirect_to(@snort_rule) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @snort_rule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /snort_rules/1
  # DELETE /snort_rules/1.xml
  def destroy
    @snort_rule = SnortRule.find(params[:id])
    @snort_rule.destroy

    respond_to do |format|
      format.html { redirect_to(snort_rules_url) }
      format.xml  { head :ok }
    end
  end
end
