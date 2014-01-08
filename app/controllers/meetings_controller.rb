class MeetingsController < ApplicationController
  respond_to :json
  
  DEFAULT_DISTANCE = 10.freeze
  
  # /meetings.json?search=Everett
  def index
    # Geocode
    # Geocoder.search(params[:search])
    
    if params[:search].present?
      respond_with Meeting.near(params[:search], DEFAULT_DISTANCE, :order => :time)
    else
      respond_with Meeting.all
    end
  end

  # GET /meetings/1582.json
  def show
    respond_with Meeting.find(params[:id])
  end

  # POST /meetings.json
  def create
    @meeting = Meeting.create(params[:meeting])
    
    if @meeting.save
      render json: @meeting, status: :created, location: @meeting
    else
      render json: @meeting.errors, status: :unprocessable_entity
    end
  end

  # PUT /meetings/1.json
  def update
    @meeting = Meeting.find(params[:id])

    if @meeting.update_attributes(params[:meeting])
      head :no_content
    else
      render json: @meeting.errors, status: :unprocessable_entity
    end
  end

  # DELETE /meetings/1.json
  def destroy
    respond_with Meeting.destroy(params[:id])
  end
end
