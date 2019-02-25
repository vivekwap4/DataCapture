require 'rails_helper'
require 'spec_helper'

describe ResearcherController do
  describe 'Sign Up Page' do

    # before(:all) do
    #   @user = Authentication.new(:email=>'nabeelahmadkh@gmail.com', :password=>'test1234', :usertype=>'researcher', :access=>'user', :session_token => 'jasub2ubub')
    #   @user.save!
    # end

    it 'should create a user and return appropriate flash notice' do
      fake_result = double('researcher')
      allow(Researcher).to receive(:create_researcher).
        and_return(fake_result)
      post :createResearcher, {:firstname => 'Ted', :lastname => 'jacob', :email => 'ted@test.com', :researchgroup => 'test', :password => 'P@ssw0rd', :confirmpassword => 'P@ssw0rd'}
      expect(flash[:notice]).to eq("User is Successfully Created, Logged In")
      expect(response).to redirect_to('/researcher/researcher_landing_page')
    end

    it 'should check to see if email is already being used' do
      fake_result = double('researcher')
      allow(Researcher).to receive(:create_researcher).
        and_return(fake_result)
      post :createResearcher, {:firstname => 'Ted', :lastname => 'jacob', :email => 'ted@test.com', :researchgroup => 'test', :password => 'P@ssw0rd', :confirmpassword => 'P@ssw0rd'}
      fake_result_copy = double('researcher')
      allow(Researcher).to receive(:create_researcher).
        and_return(fake_result_copy)
      post :createResearcher, {:name => 'Mike', :email => 'ted@test.com', :researchgroup => 'test', :password => 'P@ssw0rd2', :confirmpassword => 'P@ssw0rd2'}
      expect(flash[:notice]).to eq("Error, User already Exists")
      expect(response).to redirect_to('/researcher/signup')
    end

    it 'should alert the user if the passwords do not match' do
      fake_result = double('researcher')
      allow(Researcher).to receive(:create_researcher).
        and_return(fake_result)
      post :createResearcher, {:name => 'Nicole', :email => 'nicole@test.com', :researchgroup => 'test', :password => 'P@ssw0rd', :confirmpassword => 'P@ssw0rd2'}
      expect(flash[:notice]).to eq("Passwords not matching")
      expect(response).to redirect_to('/researcher/signup/')
    end

    it 'update the researcher profile fails' do
      fake_result = double('researcher')
      allow(Researcher).to receive(:find_by).
        and_return(fake_result)
      post :update, {:firstname => 'nabeel', :lastname => 'khan', :email => 'nabeelahmadkh@gmail.com', :researchgroup => 'test'}
      expect(response).to redirect_to('/')
    end

    it 'update the researcher profile' do
      fake_result = Researcher.new(:firstname => 'nabeel', :lastname => 'khan', :researchgroup => 'researcher')

      allow(Researcher).to receive(:find_by).
        and_return(fake_result)

      session[:session_token]='1234'
      session[:usertype] = 'researcher'
      fake_result1 = Authentication.new(:email => "test12@gmail.com", :password => 'dsd', :usertype => 'researcher', :access => 'user', :session_token => '12345678')
      expect(Authentication).to receive(:find_by_session_token).and_return fake_result1

      post :update, {'firstname' => 'nabeel', 'lastname' => 'khan', 'email' => 'nabeelahmadkh@gmail.com', 'researchgroup' => 'test'}
      expect(response).to redirect_to('/profile')
    end

    it 'if the researcher is logged in he should bw taken to researcher landing page ' do
      session[:session_token]='1234'
      session[:usertype] = 'researcher'
      fake_result1 = Authentication.new(:email => "test12@gmail.com", :password => 'dsd', :usertype => 'researcher', :access => 'user', :session_token => '12345678')
      fake_result2 = Researcher.new(:firstname => 'nabeel', :lastname => 'khan', :researchgroup => 'researcher', :id => 1)
      expect(Authentication).to receive(:find_by_session_token).and_return fake_result1
      expect(Researcher).to receive(:find_by_authentications_id).and_return fake_result2

      get :researcher_landing_page
      expect(response).to render_template('researcher/researcher_landing_page')
    end

    it 'if the researcher is not logged in he should bw taken to home page ' do
      session[:session_token]=nil
      session[:usertype] = nil
      fake_result1 = Authentication.new(:email => "test12@gmail.com", :password => 'dsd', :usertype => 'researcher', :access => 'user', :session_token => '12345678')
      expect(Authentication).to receive(:find_by_session_token).and_return fake_result1

      get :researcher_landing_page
      expect(response).to redirect_to('/')
    end

    it 'rendering of signup page' do
      get :signuppage
      expect(response).to render_template('researcher/signuppage')
    end
  end

  describe ' create researcher forms ' do
    render_views

    before(:each) do
      @authentication1 = Authentication.create(:email => "test12@gmail.com", :password => 'dsd', :usertype => 'researcher', :access => 'user', :session_token => '12345678')
      @researcher1 = Researcher.create(:firstname => 'nabeel', :lastname => 'khan', :researchgroup => 'researcher', :authentications_id => @authentication1.id)
      @project1 = Project.create(:project_name => 'test project', :research_group => 'test group', :researchers_id => @researcher1.id)
      @form1 = Form.create(:form_name => 'test form', :projects_id => @project1.id)
      @resultStaging1 = Resultsstaging.create(:forms_id => @form1.id, :jsondata => {'name' => 'testdata'})
      session[:session_token]= '12345678'
      session[:usertype] = 'researcher'
    end

    it 'should render generate form page for all the researcher ' do
      get :generateform
      expect(response).to render_template('generateform')
    end

    it 'if the researcher is not logged in then it should redirect to landing page ' do
      session[:session_token]= nil
      session[:usertype] = nil
      get :generateform
      expect(response).to redirect_to('/researcher/researcher_landing_page')
    end

    it 'should be able to create and save the form ' do
      post :createform, {"project"=>"1", "formname"=>"Test Form", "authenticity_token"=>"G/avn6rWIUWGDqnfFNAtRi6Lk8RW6jacR5qC8Gu4oZMS1jBNPxUHfTr71e95DJIyJ/R08R7fq1JNMahedP2t+g==", "formfield1"=>"Name", "formfield1type"=>"String", "formfield1typelength"=>"10", "formfield2"=>"Stay", "formfield2type"=>"Integer", "formfield2typemin"=>"5", "formfield2typemax"=>"10", "formfield3"=>"Date ", "formfield3type"=>"Date", "formfield3typemindate"=>"2018-12-01", "formfield3typemaxdate"=>"2018-12-25", "formfield4"=>"Diseases", "formfield4type"=>"Categorical", "formfield4category"=>["disease 1", "diseaese 2"], "controller"=>"researcher", "action"=>"createform"}
      expect(flash[:notice]).to eq("Form successfully added")
      expect(response).to redirect_to('/researcher/researcher_landing_page')
    end

    it 'should be able to grant excess to users ' do
      get :grantaccess
      expect(response).to render_template('grantaccess')
    end

    it 'list all the projects belonging to the researcher logged in' do
      get :approvedata

      expect(response).to render_template('researcher/approvedata')
      expect(response.body).to include('Select Project')
    end

    it 'update the result in staging 'do
      post :updateresults, {:resultstagingID => @resultStaging1.id}
      expected = {:update => true}.to_json
      response.header['Content-Type'].should include 'application/json'
      expect(response.body).to eq(expected)
    end

    it 'delete the result in staging 'do
      post :deletedata, {:resultstagingID => @resultStaging1.id}
      expected = {:update => true}.to_json
      response.header['Content-Type'].should include 'application/json'
      expect(response.body).to eq(expected)
    end

    it 'edit the result in staging 'do
      post :editdata, {:resultstagingID => @resultStaging1.id}
      expected = {:update => true}.to_json
      response.header['Content-Type'].should include 'application/json'
      expect(response.body).to eq(expected)
    end

    it 'displayed the archieved forms ' do
      get :archive
      expect(response).to render_template('archive')
    end
  end
end
