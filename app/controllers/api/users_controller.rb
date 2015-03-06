class UsersController < ApplicationController
  
  #before_action :api_key
  
  respond_to :json, :xml
  
  def index 
    users = User.limit(@limit).offset(@offset).includes(:event)
    
    # count existing users
    amountOfUsers = User.distinct.count(:id)
    
    respond_with users
  end
  
  def new
    #@user = User.new
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
  
  # Loginmethod
  def login
    u = User.find_by_email(params[:email])
    if u && u.authenticate(params[:password])
      session[:userid] = u.id
      redirect_to event_path
    else
      flash[:danger] = "Felaktigt användarnamn/lösenord!"
      redirect_to root_path
    end
  end
  
  # Logoutmethod
  def logout
    flash[:warning] = "Du är nu utloggad"
    session[:userid] = nil
    redirect_to root_path
  end
  
  # Method for removing API-keys
  def destroy
    @user = User.find(params[:id])
    @user.update_attribute(:api_key, nil)
    redirect_to apikey_path
  end
  
  private 
  
  def user_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
    json_params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
end
