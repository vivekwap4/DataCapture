class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_current_user
    @session_token = session[:session_token]
    @usertype = session[:usertype]
    user = Authentication.find_by_session_token(@session_token)
    if user
      @id = user.id
    end
    if user
      @useremail = user.email
    else
      @useremail = nil
    end
  end
end
