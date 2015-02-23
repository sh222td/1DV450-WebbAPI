class EventsController < ApplicationController
  respond_to :json, :xml
  
  def index 
    event = Event.all
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def create
    
  end
  
end
