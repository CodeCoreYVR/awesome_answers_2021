class ApplicationController < ActionController::Base

  private

  # returns current user if there is a current user
  def current_user
    if session[:user_id].present?
      @current_user ||= User.find session[:user_id] # ||= will only assign @current_user if it is nil. Otherwise continue using it's
    end
  end
  helper_method :current_user
  #helper_method is a rails method that makes controller methods available as helpers on views

  # checks if current_user is nil or not
  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def authenticate_user!
    unless user_signed_in?
      flash[:danger] = "You need to be signed in first!"
      redirect_to new_session_path
    end
  end
end
