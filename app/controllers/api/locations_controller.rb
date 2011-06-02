class Api::LocationsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :throw_404 
  
  # Track by fleet
  def index
    
  end
  
  def fleet
    @ids = params[:fleet_ids].scan(/\d+/)
    @devices = Device.find_all_by_device_code(@ids)
    @locations = []
    
    @devices.each do |dev|
      status = dev.gps_statuses.order('time DESC').limit(1)
      
      if (status.length > 0)
        @locations.push(:device_code => dev.device_code.to_s, :status => status[0])
      end
    end
    
    respond_to do |format|
      format.json { render :json => @locations }
      format.xml  { render :xml => @locations }
    end
  end
  
  def detail
    @device = Device.find_by_device_code!(params[:device_code])
    
    @location = GpsStatus
    
    if (!params[:start_time].nil? && !params[:end_time].nil?)
      @location = @location.where(:time => (Time.at(params[:start_time].to_i)..Time.at(params[:end_time].to_i)))
    elsif (!params[:start_time].nil?)
      @location = @location.where(:time => (Time.at(params[:start_time].to_i)..Time.now))
    end
    
    @locations = @location.find_all_by_device_id(@device.id)
    
    respond_to do |format|
      # format.html
      format.json { render :json => @locations }
      format.xml  { render :xml => @locations }
    end
  end
  
  def throw_404
    respond_to do |format|
        # format.html
        format.json { render :json => [], :status => 404 }
        format.xml  { render :xml => [], :status => 404 }
      end
  end
  
end
