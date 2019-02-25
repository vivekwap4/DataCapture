require 'spec_helper'
require 'rails_helper'

describe FormaccessController do
  describe 'check formacces controller functions' do
    it 'get all the formaccess users ' do

      fake_result1 = Formsaccess.new(:forms_id => 1, :dataentries_id => 1)
      expect(Formsaccess).to receive(:where).and_return fake_result1

      post :getformsuser, {'form' => 1}
      response.header['Content-Type'].should include 'application/json'

      parsed_body = JSON.parse(response.body)
      parsed_body["forms_id"].should == 1
    end

    it 'get empty json if forms id is not passed' do

      post :getformsuser, {}
      response.header['Content-Type'].should include 'application/json'

      expectedResponse = {}.to_json

      expect(response.body).to eq(expectedResponse)
    end

    it 'should update the form access for data entry' do
      fake_result1 = Formsaccess.new(:forms_id => 1, :dataentries_id => 1)
      expect(Formsaccess).to receive_message_chain(:where, :destroy_all).and_return nil
      # formaccess = Formsaccess.new(id: 1, forms_id: 1, dataentries_id: 1)
      # expect(fake_result1).to receive(:destroy_all)

      post :updateformaccess, {'dataentry_id' => [1]}

      expect(response).to redirect_to('/researcher/researcher_landing_page')
    end

    it 'should display all the dataentry forms ' do
      @user2 = Authentication.create(:email => "test13@gmail.com", :password => 'dsd', :usertype => 'dataentry', :access => 'user', :session_token => '12345')
      @dataentry2 = Dataentry.create(:firstname => 'nabeel', :lastname => 'khan', :profile => 'epi', :institution => 'test',:authentications_id => @user2.id)
      @form = Form.create(:form_name => 'test form', :projects_id => '1')
      @formaccess = Formsaccess.create(:forms_id => @form.id, :dataentries_id => @dataentry2.id)
      session[:session_token]= '12345'
      session[:usertype] = 'dataentry'
      get :displaydataentryforms

      expect(response).to render_template('dataentry_landing_page')
    end

    it 'should redirect to login page for the users that are not logged in ' do
      get :displaydataentryforms
      expect(response).to redirect_to('/login')
    end
  end
end
