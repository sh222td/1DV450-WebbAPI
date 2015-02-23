class UsersController < ApplicationController
  respond_to :json, :xml
  
  def index 
    users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
end
