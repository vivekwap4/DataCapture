class HomepageController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    # this will render views/homepage/tutorialpage.html.haml
    redirect_to '/login'
  end
end
