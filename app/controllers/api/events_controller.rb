class Api::EventsController < ApplicationController
  
  respond_to :json, :xml
  
  before_action :offset_params, only: [:index, :nearby]
  
  def index 
    events = Event.limit(@limit).offset(@offset)
    respond_with events
  end
  
  def show
    @event = Event.find(params[:id])
    respond_with @team, location: api_events_path(@event)
    
    rescue ActiveRecord::RecordNotFound
    @ErrorMessage.new("Could not find that resource. Are you using the right event_id?", "The event was not found!")
    respond_with @error, status: :not_found
    
  end
  
  def create
    
    event = Event.new(event_params)
    
    if event.save
      respond_with event, status: :created
    else
      error = ErrorMessage.new("Could not create the resource. Bad parameters?", "Could not create the resource")
      render json: error, status: :bad_request
    end
    
  end
  
  def nearby
    # check parameters
    if params[:longitude].present? && params[:latitude].present?
      e = Event.near(params[latitude].to_f, params[:longitude].to_f, 20).limit(@limit).offset(@offset)
      respond_with e, status: :ok
    else 
      error = ErrorMessage.new("Could not find any resources. Bad parameters?", "Could not find any events!")
      render json: error, status: :bad_request
    end
  end
  
  private 
  
  def raise_bad_format
    @error = ErrorMessage.new("The API does not support the requested format?", "There was a bad call. Contact the developer!")
    render json: error, status: :bad_request
  end
  
  # strong parameters
  def event_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
    json_params.require(:event).permit(:userID, :positionID, :tagID, :description)
  end
end

# class for errormessages
class ErrorMessage

  def initialize(dev_msg, usr_msg)
    @developerMessage = dev_msg
    @userMessage = usr_msg
  end

  def to_xml(options={})
    str = "<error>"
    str += "<deverloperMessage>#{@developerMessage}</developerMessage>"
    str += "<userMessage>#{@userMessage}</userMessage>"
    str = "</error>"
  end

end
    
  
