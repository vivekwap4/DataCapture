require 'spec_helper'
require 'rails_helper'

describe DataentryController do

  describe 'create data entry' do

    it 'should check to see if email is already being used' do
      fake_result = double('data_entry')
      allow(Dataentry).to receive(:create_dataentry).
        and_return(fake_result)
      post :createDataEntry, {:firstname=> 'Ted', :lastname => 'Jacob', :email => 'ted@test.com', profile: 'profile', :institution => 'test', :password => 'P@ssw0rd', :confirmpassword => 'P@ssw0rd'}
      fake_result_copy = double('data_entry')
      allow(Dataentry).to receive(:create_dataentry).
        and_return(fake_result_copy)
      post :createDataEntry, {:name => 'Mike', :email => 'ted@test.com', profile: 'profile', :institution => 'test', :password => 'P@ssw0rd2', :confirmpassword => 'P@ssw0rd2'}
      expect(flash[:notice]).to eq('Error, User already Exists')
      expect(response).to redirect_to('/dataentry/signup')
    end

    it 'should alert the user if the passwords do not match' do
      fake_result = double('data_entry')
      allow(Dataentry).to receive(:create_dataentry).
        and_return(fake_result)
      post :createDataEntry, {:name => 'Nicole', :email => 'nicole@test.com', profile: 'profile', :institution => 'test', :password => 'P@ssw0rd', :confirmpassword => 'P@ssw0rd2'}
      expect(flash[:notice]).to eq('Passwords not matching')
      expect(response).to redirect_to('/dataentry/signup/')
    end
    # it 'should display correct message if data entry user not created' do
    #   user = nil
    #   allow(AuthenticationController).to receive(:createuser).with(nil).and_return(user)
    #   expect(flash[:notice]).to eq('Error, User cannot be created')
    #   expect(response).to redirect_to('/dataentry/signup/')
    # end
    # it 'should set up data entry account' do
    #  mock_return = double('data_entry_double')
    #  expect(Dataentry).to receive(:create_dataentry)
    #    .with({firstname: 'ex_first', lastname: 'ex_last', email: 'ex_email@test.com', profile: 'ex_profile', institution: 'ex_inst', password: 'P@ssw0rd', confirmpassword: 'P@ssw0rd'})
    #    .and_return(mock_return)
    #  post :createDataEntry, {firstname: 'ex_first', lastname: 'ex_last', email: 'ex_email@test.com', profile: 'ex_profile', institution: 'ex_inst', password: 'P@ssw0rd', confirmpassword: 'P@ssw0rd'}
    # end
  end
  describe 'data entry login' do
    # it 'should allow user login' do
    #   fake_user = double('user')
    #   fake_email = double('email')
    #   allow(Authentication).to receive(:find_by_email).with(fake_email).and_return(fake_user)
    # end
    #
    # # it 'should destroy session token on logout' do
    # #   session[:session_token] = '1234'
    # #   session[:usertype] = 'dataentry'
    # #
    # #   fake_result1 = Authentication.new(:email => "test@gmail.com", :password => 'dsd', :usertype => 'dataentry', :access => 'user', :session_token => '12345678')
    # #   expect(Authentication).to receive(:find_by_session_token).and_return fake_result1
    # #
    # #   get :destroy
    # #   expect(session[:session]).to eq(nil)
    # #   expect(response).to redirect_to('/')
    # #   expect(flash[:notice]).to eq('You are successfully logged out')
    # # end

    # it 'should allow data entry user to login' do
    #   @testuser = Authentication.create(:email => 'duser@email.com', :password => Digest::MD5.hexdigest('1234'), :usertype => 'dataentry', :access=> 'user', :session_token => '1234')
    #   @duser = Dataentry.create(:firstname => 'first', :lastname => 'last', :profile => 'profile', :institution => 'institution', :authentications_id => @testuser.id)
    #   session[:session_token] = '1234'
    #   session[:usertype] = 'dataentry'
    #
    #   post :login,{'email' => @testuser.email, 'password' => '1234'}
    #   expect(response).to redirect_to('dataentry_landing_page')
    # end
    # it 'should redirect to login if the user type is not dataentry' do
    #   @testuser = Authentication.create(:email => 'duser@email.com', :password => Digest::MD5.hexdigest('1234'), :usertype => 'dataentry', :access=> 'user', :session_token => '1234')
    #   @duser = Dataentry.create(:firstname => 'first', :lastname => 'last', :profile => 'profile', :institution => 'institution', :authentications_id => @testuser.id)
    #   session[:session_token] = nil
    #   post :login,{'email' => @testuser.email, 'password' => '1234'}
    #   expect(response).to redirect_to('/login')
    # end
  end

  describe 'update' do
    it 'should update user details' do

      @testuser = Authentication.create(:email => 'duser@email.com', :password => Digest::MD5.hexdigest('1234'), :usertype => 'dataentry', :access=> 'user', :session_token => '1234')
      @duser = Dataentry.create(:firstname => 'first', :lastname => 'last', :profile => 'profile', :institution => 'institution', :authentications_id => @testuser.id)
      session[:session_token] = '1234'
      session[:usertype] = 'dataentry'
      get :update,{'firstname' => 'testfirst', 'lastname' => 'testlast', 'profile' => 'testprofile', 'institution' => 'UIowa'}
      expect(response).to redirect_to('/profile')
    end
    it 'should redirect if the user is not dataentry' do
      get :update,{'firstname' => 'testfirst', 'lastname' => 'testlast', 'profile' => 'testprofile', 'institution' => 'UIowa'}
      session[:session_token] = nil
      session[:usertype] = nil
      expect(response).to redirect_to('/')
    end
  end

  describe 'display forms' do
    render_views
    it 'should display forms for dataentry users' do
      @formtest = Form.create(:form_name=>'test form', :projects_id => '1')

      @formattributes1 = Formattribute.create(:column_name => 'Name', :column_type => 'String', :forms_id => @formtest.id, :categorical => 'false')
      @formattributes2 = Formattribute.create(:column_name => 'Admit Date', :column_type => 'Date', :forms_id => @formtest.id, :categorical => 'false')
      @formattributes3 = Formattribute.create(:column_name => 'Length of Stay', :column_type => 'Integer', :forms_id => @formtest.id, :categorical => 'false')
      @formattributes4 = Formattribute.create(:column_name => 'test name', :column_type => 'Categorical', :forms_id => @formtest.id, :categorical => 'true')

      @categorical1 = Categoricalformattribute.create(:formattributes_id => @formattributes1.id, :option => '10', :name => 'length')
      @categorical2 = Categoricalformattribute.create(:formattributes_id => @formattributes2.id, :option => '2017-01-01', :name => 'mindate')
      @categorical3 = Categoricalformattribute.create(:formattributes_id => @formattributes2.id, :option => '2018-01-01', :name => 'maxdate')
      @categorical4 = Categoricalformattribute.create(:formattributes_id => @formattributes3.id, :option => '0', :name => 'minlength')
      @categorical5 = Categoricalformattribute.create(:formattributes_id => @formattributes3.id, :option => '100', :name => 'maxlength')

      Categoricalformattribute.create(:formattributes_id => @formattributes4.id, :option => 'cat_1', :name => 'categorical')
      Categoricalformattribute.create(:formattributes_id => @formattributes4.id, :option => 'cat_2', :name => 'categorical')

      get :displayform, {'formid' => @formtest.id}

      expect(response).to render_template('displayform')
    end
  end

  describe 'update page' do
    render_views
    before(:each) do
      @testuser = Authentication.create(:email => 'duser@email.com', :password => Digest::MD5.hexdigest('1234'), :usertype => 'dataentry', :access=> 'user', :session_token => '1234')
      @duser = Dataentry.create(:firstname => 'first', :lastname => 'last', :profile => 'profile', :institution => 'institution', :authentications_id => @testuser.id)
      session[:session_token] = '1234'
      session[:usertype] = 'dataentry'
    end

    it 'should update' do
      get :updatepage
      @project = Project.create(:project_name => 'testproject', :research_group => 'test group', :researchers_id => '1')
      @form = Form.create(:form_name => 'testform', :projects_id => @project.id)
      @formsaccess = Formsaccess.create(:forms_id => @form.id, :dataentries_id => '2')
      expect(response).to render_template('update')
    end

    it 'should redirect to login page if user is not data entry' do
      session[:session_token] = nil
      get :updatepage
      expect(response).to redirect_to('/login')
    end
  end

  describe 'get all users' do
    it 'should get all users in JSON' do
      @testuser = Authentication.create(:email => 'duser@email.com', :password => Digest::MD5.hexdigest('1234'), :usertype => 'dataentry', :access=> 'user', :session_token => '1234')
      @duser = Dataentry.create(:firstname => 'first', :lastname => 'last', :profile => 'profile', :institution => 'institution', :authentications_id => @testuser.id)

      get :getallusers
      response.header['Content-Type'].should include 'application/json'
    end
  end

  describe 'get records to update' do
    it 'should get records to be updated in JSON' do
      @project = Project.create(:project_name => 'testproject', :research_group => 'test group', :researchers_id => '1')
      @formtest = Form.create(:form_name => 'testform', :projects_id => @project.id)
      @resultstaging = Resultsstaging.create(:forms_id => @formtest.id, :updateneeded => 'true', :jsondata =>{
        "Name": "Nabeel",
        "formID": @formtest.id,
        "Admit Date": "2018-11-16",
        "Room Number": "111",
        "Discharge Date": "2018-11-16",
        "Length of Stay": "10"
      })

      get :getrecordstoupdate,{'form' => @formtest.id}

      # expected = {success => true}.to_json
      # response.header[‘Content-Type’].should include ‘application/json’
      # expect(response.body).to eq(expected)
      response.header['Content-Type'].should include 'application/json'
    end
  end

  describe 'get form to edit' do

    it 'should return forms to be edited in JSON' do
      @projecttest = Project.create(:project_name => 'testproject', :research_group => 'test group', :researchers_id => '1')
      @formtest = Form.create(:form_name => 'testform', :projects_id => @projecttest.id)
      @formattribute = Formattribute.create(:column_name => 'Name', :column_type => 'String', :forms_id => @formtest.id)
      get :getformtoedit,{'form' => @formtest.id}

      # expected = {'column_name' => 'Name', 'column_type' => 'String', 'forms_id' => @formtest.id}.to_json
      # expected = @formattribute.to_json
      response.header['Content-Type'].should include 'application/json'
      # expect(response.body).to eq(expected)
    end

  end

  describe 'update form data' do
    it 'should update form data' do
      @projecttest = Project.create(:project_name => 'testproject', :research_group => 'test group', :researchers_id => '1')
      @formtest = Form.create(:form_name => 'testform', :projects_id => @projecttest.id)
      @formattribute = Formattribute.create(:column_name => 'Name', :column_type => 'String', :forms_id => @formtest.id)
      @resultstaging = Resultsstaging.create(:forms_id => @formtest.id, :jsondata =>{
        "Name": "Nabeel",
        "formID": @formtest.id,
        "Admit Date": "2018-11-16",
        "Room Number": "111",
        "Discharge Date": "2018-11-16",
        "Length of Stay": "10"
      })

      post :updateformdata,{'resultid' => @resultstaging.id, 'formid' => @formtest.id}
      expect(response).to redirect_to('/dataentry/update')
    end
  end

end
