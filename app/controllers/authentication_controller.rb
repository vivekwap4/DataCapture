# require 'aws-sdk-s3'  # v2: require 'aws-sdk'
require 'aws-sdk'
require 'json'

class AuthenticationController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_current_user, :set_authentication

  def self.createuser(attribute)
    Authentication.create_user(attribute)
  end

  def set_authentication
    @authentication = Authentication.find_by_session_token(@session_token)
  end

  def loginpage
    if @session_token and @usertype == 'researcher'
      redirect_to '/researcher/researcher_landing_page'
    end
    if @session_token and @usertype == 'dataentry'
      redirect_to '/dataentry/dataentry_landing_page'
    end
    # Renders views/researcher/loginpage.html.haml
  end

  def login
    user = Authentication.find_by_email(params['email'])
    if user.blank?
      print "\n\n PARAMS RECIBEDD ARE 2",params
      flash[:notice] = 'User does not exist'
      flash[:success] = 1
      redirect_to '/researcher/signup'
    elsif user and (Digest::MD5.hexdigest(params['password']) == user.password) and (params['logintype'] == user.usertype)
      print "\n\n PARAMS RECIBEDD ARE 3",params
      session[:session_token] = user.session_token
      session[:usertype] = user.usertype
      if user.usertype == 'researcher'
        print "\n\n PARAMS RECIBEDD ARE 4",params
        researcher = Researcher.find_by_authentications_id(user.id)
        session[:firstname] = researcher.firstname
        flash[:success] = 1
        flash[:notice] = 'User logged In'
        redirect_to '/researcher/researcher_landing_page'
      elsif user.usertype == 'dataentry'
        dataentry = Dataentry.find_by_authentications_id(user.id)
        session[:firstname] = dataentry.firstname
        flash[:success] = 1
        flash[:notice] = 'Welcome to Data Entry Home Page'
        redirect_to '/dataentry/dataentry_landing_page'
      else
        session[:session_token] = nil
        session[:usertype] = nil
        flash[:notice] = 'Invalid Login ID or Password'
        flash[:success] = 0
        redirect_to '/login'
      end
    else
      print "\n\n PARAMS RECIBEDD ARE 5",params
      flash[:notice] = 'Email or Password wrong!!!'
      flash[:success] = 0
      redirect_to '/login'
    end
  end

  def destroy
    session[:session_token] = nil
    session[:usertype] = nil
    flash[:notice] = 'User successfully logged out.'
    redirect_to '/'
  end

  def forgotpassword
    # Renders views/authentication/forgotpassword.html.haml
  end

  def sendresetlink
    print "\n PARAMS ARE ",params
    user = Authentication.find_by_email(params['email'])
    if user and (user.usertype == params['usertype'])
      reset_token = SecureRandom.hex(20)

      #TODO: Add Domain in the Base URL
      url = "http://localhost:3000/resetpassword/" + user.id.to_s + "/" + reset_token

      user.update(reset_token: reset_token)

      # Send the link by email to the user
      UserMailer.password_reset(params['email'], url).deliver_now

      flash[:notice] = "Reset link sent to your Email"
      flash[:success] = 1
    else
      flash[:success] = 0
      flash[:notice] = "Email Not Found or Wrong User Type"
    end
    redirect_to "/login"
  end

  def resetpassword
    user = Authentication.find_by_id(params['userid'])
    currenttime = Time.now()

    # Checking validity of the session token
    if user and (user.reset_token == params['reset_token']) and (currenttime - user.updated_at).to_i < 1800
      @reset_token = user.reset_token
      render "authentication/resetpassword"
    else
      flash[:notice] = "Incorrect Reset Password Link"
      redirect_to '/'
    end
  end

  def updatepassword
    user = Authentication.find_by_reset_token(params['reset_token'])

    if user and (params['password'] == params['confirmpassword'])
      user.password = Digest::MD5.hexdigest(params['password'])
      user.reset_token = nil
      user.save
      flash[:notice] = "Password Updated Successfully"
      flash[:success] = 1
    else
      flash[:notice] = "Passwords Not Matching"
      flash[:success] = 0
    end
    redirect_to '/login'
  end

  def profile
    if @session_token and @usertype == 'researcher'
      user = Authentication.find_by_session_token(@session_token)
      if user
        researcher_user = Researcher.find_by_authentications_id(user.id)
        @user = {
          :firstname => researcher_user.firstname,
          :lastname => researcher_user.lastname,
          :email => user.email,
          :researchgroup => researcher_user.researchgroup
        }
        render 'authentication/researcherprofile'
      else
        flash[:notice] = "Internal Error, cannot load data!!!"
        flash[:success] = 0
        redirect_to '/'
      end
    elsif @session_token and @usertype == 'dataentry'
      user = Authentication.find_by_session_token(@session_token)
      if user
        dataentry_user = Dataentry.find_by_authentications_id(user.id)
        @user = {
          :firstname => dataentry_user.firstname,
          :lastname => dataentry_user.lastname,
          :email => user.email,
          :profile => dataentry_user.profile,
          :institution => dataentry_user.institution
        }
        render 'authentication/dataentryprofile'
      else
        flash[:notice] = "Internal Error, cannot load data!!!"
        flash[:success] = 0
        redirect_to '/'
      end
    else
      flash[:notice] = "Login to View profile"
      flash[:success] = 0
      redirect_to '/login'
    end
  end

  def updateprofile
    @authentication.update(authentication_params)
    redirect_to '/profile'
  end

  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.

    def authentication_params
      params.require(:authentication).permit(:avatar)
    end

end
