class UsersController < ApplicationController
  require 'net/http'
  def new
    uri = URI("https://maps.googleapis.com/maps/api/js?key=#{ENV['GOOGLE_API_KEY']}&callback=initMap")
    @google_maps_js = Net::HTTP.get_response(uri).body
    @user = User.new
    # form_with uses an instance to create a form
  end

  def create
    @user = User.new params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar)
    if @user.save
      flash.delete(:warning)
      redirect_to questions_path
    else
      flash[:warning] = "unable to create user"
      render :new
    end
  end

  def edit
    # @user User.find session[:user_id]
    @user = current_user # the current_user method already fetches the logged in user for us
  end

  def update
    @user = current_user
    user_params = params[:user]
    if (current_user.authenticate(user_params[:current_password])) # authenticate same password
      if (user_params[:new_password] == user_params[:new_password_confirmation]) # check if new password and confirmation are same
        # @user.password = user_params[:new_password]
        # if @user.update({password_digest: @user.password_digest})
        if @user.update({password: user_params[:new_password]})
          # because of has_secure_password adding a password attribute to a user will automatically update and hash a password_digest attribute
          # has_secure_password will also have a validation to make sure the attributes `password` and `password_digest` are the same
          flash[:success] = "password updated"
          redirect_to root_path
        else
          flash[:danger] = "password not updated"
          render :edit
        end
      end
    end
  end
end
