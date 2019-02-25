require 'spec_helper'
require 'rails_helper'

describe ResultController do

  before(:each) do
    @form = Form.create(:form_name => 'testForm', :projects_id => '1', :archive => false)
    @formattributes = Formattribute.create(:column_name => 'Name', :column_type => 'String', :forms_id => @form.id)
    @formattributes = Formattribute.create(:column_name => 'Length Of Stay', :column_type => 'Integer', :forms_id => @form.id)
  end

  describe 'test save staging data' do
    it 'it should be able to save data and redirect to landing page' do
      post :savestagingdata, {'formId' => '1', 'Name' => 'nabeel', 'Length Of Stay' => '10'}

      expect(response).to redirect_to('/dataentry/dataentry_landing_page')
    end
  end

  describe 'get staging data' do
    it 'it should be able to retrieve staging data from result staging table' do
      Resultsstaging.create(:forms_id => @form.id, :jsondata => {'Name' => 'Nabeel', 'Length Of Stay' => '10'})

      post :getstagingdata, {'formid' => @form.id}

      response.header['Content-Type'].should include 'application/json'
    end
  end

end
