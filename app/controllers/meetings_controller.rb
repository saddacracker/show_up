class MeetingsController < ApplicationController

  # GET /meetings
  # GET /meetings.json
  def index
    
    # @meetings = Meeting.all
    
    @user_location = request.location

    # ==================================================
    # = @TODO: REDO THE QUERIES! Use group_by and sort =
    # ==================================================
    
    # define the meetings
    # there has to be a way to DRY this up, besides looping and concatinating
    if params[:search].present?
      search_params = params[:search]
      
      # set map location based on params
      @map_location = Geocoder.search(params[:search]);
      @map_location = @map_location[0]
    else
      if @user_location.city.present?
        search_params = @user_location.city
      else
        search_params = "Seattle, WA"
      end
      
      @map_location = @user_location      
    end
    
    @search_params = search_params
    
    # @TODO: use group_by
    @meetings_on_sunday     = Meeting.has_sunday("1").near(search_params, 25, :order => :time)
    @meetings_on_monday     = Meeting.has_monday("1").near(search_params, 25, :order => :time)
    @meetings_on_tuesday    = Meeting.has_tuesday("1").near(search_params, 25, :order => :time)
    @meetings_on_wednesday  = Meeting.has_wednesday("1").near(search_params, 25, :order => :time)
    @meetings_on_thursday   = Meeting.has_thursday("1").near(search_params, 25, :order => :time)
    @meetings_on_friday     = Meeting.has_friday("1").near(search_params, 25, :order => :time)
    @meetings_on_saturday   = Meeting.has_saturday("1").near(search_params, 25, :order => :time)
    
    # Concatinate all the meetings VS querying 
    # Meeting.near(search_params, 25, :order => :time)
    @all_results = @meetings_on_sunday + @meetings_on_monday + @meetings_on_tuesday + @meetings_on_wednesday + @meetings_on_thursday + @meetings_on_friday + @meetings_on_saturday
    
    if @all_results.blank?
      flash[:notice] = "Sorry no meetings listed in your area."
    else
      @all_results = @all_results.to_json(:only => [:title, :address, :latitude, :longitude, :distance, :closed_meeting, :tags, :week_days, :time])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @all_results }
    end
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])
    # @lat_lng = cookies[:lat_lng].split("|")


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting }
      format.js do
       render :js => "$('#meeting-preview').html('#{Helper.escape_js(render_to_string(:partial => 'meeting'))}');"
      end
    end
  end

  # GET /meetings/new
  # GET /meetings/new.json
  def new
    @meeting = Meeting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/1/edit
  def edit
    @meeting = Meeting.find(params[:id])
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(params[:meeting])
    
    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render json: @meeting, status: :created, location: @meeting }
      else
        format.html { render action: "new" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meetings/1
  # PUT /meetings/1.json
  def update
    @meeting = Meeting.find(params[:id])

    respond_to do |format|
      if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to meetings_url }
      format.json { head :no_content }
      format.js   { render :nothing => true } 
    end
  end
end


class Helper
  include ActionView::Helpers::JavaScriptHelper

  def self.escape_js( text )
    @instance ||= self.new
    return @instance.escape_javascript( text )
  end
end
