class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  private
 
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def require_authentication
    unless User.find_by(id: session[:user_id])
      redirect_to "/auth/github"
    end
  end
  
  def record_not_found
    flash[:notice] = "The rule requested was not found."
    redirect_to root_url # Assuming you have a template named 'record_not_found'
  end
end
