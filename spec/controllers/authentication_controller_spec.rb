require 'spec_helper'
require 'rails_helper'

describe AuthenticationController do
  describe 'renders index template page' do
    # it 'successfull creation of a user ' do
    #   fake_result1 = double('auth')
    #   expect(Authentication).to receive(:create_user).and_return fake_result1
    #   post :createuser, {:email => 'nabeelahmadkh@gmail.com'}
    # end

    it 'researcher loginpage render ' do
      session[:session_token]='1234'
      session[:usertype] = 'researcher'
      fake_result1 = Authentication.new(:email => "test12@gmail.com", :password => 'dsd', :usertype => 'researcher', :access => 'user', :session_token => '12345678')
      expect(Authentication).to receive(:find_by_session_token).twice.and_return fake_result1

      get :loginpage
      expect(response).to redirect_to('/researcher/researcher_landing_page')
    end

    it 'dataentry loginpage render ' do
      session[:session_token]='1234'
      session[:usertype] = 'dataentry'
      fake_result1 = Authentication.new(:email => "test12@gmail.com", :password => 'dsd', :usertype => 'researcher', :access => 'user', :session_token => '12345678')
      expect(Authentication).to receive(:find_by_session_token).twice.and_return fake_result1

      get :loginpage
      expect(response).to redirect_to('/dataentry/dataentry_landing_page')
    end

    it 'check researcher login' do
      @user = Authentication.create(:email=>'test321@gmail.com', :session_token=>'1234', :password=>Digest::MD5.hexdigest('1234'), :usertype => 'researcher', :access => 'user')
      @researcher = Researcher.create(:firstname => 'nabeel', :lastname => 'khan', :researchgroup => 'epi', :authentications_id => @user.id)

      post :login, {:email => 'test321@gmail.com', :password => '1234', :logintype => 'researcher'}

      expect(response).to redirect_to('/researcher/researcher_landing_page')
    end

    it 'check dataentry login' do
      @user = Authentication.create(:email=>'test321@gmail.com', :session_token=>'1234', :password=>Digest::MD5.hexdigest('1234'), :usertype => 'dataentry', :access => 'user')
      @dataentry = Dataentry.new(:firstname => 'nabeel', :lastname => 'khan', :profile => 'epi', :institution => 'test',:authentications_id => @user.id)
      @dataentry.save!

      get :login, {'email': 'test321@gmail.com', 'password': '1234', 'logintype': 'dataentry'}

      expect(response).to redirect_to('/dataentry/dataentry_landing_page')
    end

    it 'checking invalid user type in login ' do
      @user=Authentication.create(:email=>'test321@gmail.com', :session_token=>'1234', :password=>Digest::MD5.hexdigest('1234'), :usertype => '', :access => 'user')
      @dataentry = Dataentry.new(:firstname => 'nabeel', :lastname => 'khan', :profile => 'epi', :institution => 'test', :authentications_id => @user.id)
      @dataentry.save!

      get :login, {'email': 'test321@gmail.com', 'password': '1234', 'logintype': 'dataentry'}

      expect(response).to redirect_to('/login')
    end

    it 'check destroy session' do
      session[:session_token]='1234'
      session[:usertype] = 'dataentry'
      fake_result1 = Authentication.new(:email => "test12@gmail.com", :password => 'dsd', :usertype => 'researcher', :access => 'user', :session_token => '12345678')
      expect(Authentication).to receive(:find_by_session_token).twice.and_return fake_result1

      get :destroy
      expect(response).to redirect_to('/')
      expect(flash[:notice]).to eq('User successfully logged out.')
    end

    it 'check forgot password page load ' do
      get :forgotpassword
      expect(response).to render_template('authentication/forgotpassword')
    end
  end

  describe 'authentication testing 'do
    before(:each) do
      @user1 = Authentication.create(:email => "test12@gmail.com", :password => 'dsd', :usertype => 'researcher', :access => 'user', :session_token => '1234')
      @researcher1 = Researcher.create(:firstname => 'nabeel', :lastname => 'khan', :researchgroup => 'epi', :authentications_id => @user1.id)
      session[:session_token]='1234'
      session[:usertype] = 'researcher'
    end

    it 'send reset link to registered user' do
      post :sendresetlink, {:email => 'test12@gmail.com', :usertype => 'researcher'}

      expect(flash[:notice]).to eq('Reset link sent to your Email')
      expect(response).to redirect_to('/login')
    end
    it 'should not send reset link to un-registered user' do
      post :sendresetlink, {:email => 'test@gmail.com', :usertype => 'researcher'}

      expect(flash[:notice]).to eq('Email Not Found or Wrong User Type')
      expect(response).to redirect_to('/login')
    end

    it 'should render password reset link when given correct token' do
      @user1.reset_token = '1234'
      @user1.save!
      get :resetpassword, {:userid => @user1.id, :reset_token => '1234'}
      expect(response).to render_template('resetpassword')
    end

    it 'should redirect to home page if wrong parameters are given' do
      @user1.reset_token = '1234'
      @user1.save!
      get :resetpassword, {:userid => '0', :reset_token => '1234'}
      expect(response).to redirect_to('/')
    end

    it 'should be able to update password for correct reset token' do
      @user1.reset_token = '1234'
      @user1.save!
      post :updatepassword, {:password => '123', :confirmpassword => '123', :reset_token => '1234'}
      expect(flash[:notice]).to eq('Password Updated Successfully')
      expect(response).to redirect_to('/login')
    end

    it 'should not be able to update password for in-correct reset token' do
      @user1.reset_token = '1234'
      @user1.save!
      post :updatepassword, {:password => '123', :confirmpassword => '123', :reset_token => '123'}
      expect(flash[:notice]).to eq('Passwords Not Matching')
      expect(response).to redirect_to('/login')
    end

    it 'load profile page for researcher login' do
      get :profile
      # expect(flash[:notice]).to eq('Internal Error, cannot load data!!!')
      expect(response).to render_template('researcherprofile')
    end
    it 'should not load profile page for not logged in user' do
      session[:session_token]= ''
      session[:usertype] = 'researcher'
      get :profile
      expect(flash[:notice]).to eq('Internal Error, cannot load data!!!')
      expect(response).to redirect_to('/')
    end

    it 'user not logged in should be redirected to login page ' do
      session[:session_token]= nil
      session[:usertype] = nil
      get :profile
      expect(flash[:notice]).to eq('Login to View profile')
      expect(response).to redirect_to('/login')
    end

    describe 'do testing for data entry user ' do
      before (:each) do
        @user2 = Authentication.create(:email => "test13@gmail.com", :password => 'dsd', :usertype => 'dataentry', :access => 'user', :session_token => '12345')
        @dataentry2 = Dataentry.create(:firstname => 'nabeel', :lastname => 'khan', :profile => 'epi', :institution => 'test',:authentications_id => @user2.id)
        session[:session_token]= '12345'
        session[:usertype] = 'dataentry'
      end
      it 'load profile page for dataentry login' do
        get :profile
        expect(response).to render_template('dataentryprofile')
      end
      it 'should not load dataentry profile page for not logged in user' do
        session[:session_token]= ''
        get :profile
        expect(flash[:notice]).to eq('Internal Error, cannot load data!!!')
        expect(response).to redirect_to('/')
      end
    end
  end
end
