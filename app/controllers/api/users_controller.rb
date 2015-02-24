class Api::UsersController < ApplicationController
  
  #before_action :api_key
  
  respond_to :json, :xml
  
  def index 
    users = User.limit(@limit).offset(@offset).includes(:event)
    
    # count existing users
    amountOfUsers = User.distinct.count(:id)
    
    respond_with users
  end
  
  def show
    @user = User.find(params[:id])
    respond_with @user
  end
  
  def create
    user = User.new(user_params)
    # funkar inte än --> user.api_key = SecureRandom.hex
    
    if user.save
      respond_with user, status: :created
    else
      error = ErrorMessage.new("Could not create the resource. Bad parameters?", "Could not create the resource!")
      render json: error, status: :bad_request
    end
  end
  
  private 
  
  def user_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
    json_params.require(:user).permit(:username, :email, :password)
  end
  
end
