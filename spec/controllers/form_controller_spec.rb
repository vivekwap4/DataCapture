require 'spec_helper'
require 'rails_helper'

RSpec.describe FormController, :type => :controller do
  render_views

  describe 'it should list of forms in json' do
    it 'should return list of json in forms ' do

      fake_result1 = Form.new(:form_name => "test_form", :projects_id => 1)
      expect(Form).to receive(:where).and_return fake_result1

      post :getforms, {'project' => 1}
      response.header['Content-Type'].should include 'application/json'

      parsed_body = JSON.parse(response.body)
      parsed_body["form_name"].should == "test_form"
    end
  end

  describe 'should display the form given the formID ' do

    before(:each) do
      @project = Project.create(:project_name => 'test project', :research_group => 'epidimiology', :researchers_id => '1')
      @form = Form.create(:form_name => 'testForm', :projects_id => @project.id, :archive => true)
      @formattributes1 = Formattribute.create(:column_name => 'Name', :column_type => 'String', :forms_id => @form.id)
      @formattributes2 = Formattribute.create(:column_name => 'Length Of Stay', :column_type => 'Integer', :forms_id => @form.id)
      @result1 = Result.create(:forms_id => @form.id, :jsondata => {'Name' => 'Nabeel', 'Length Of Stay' => '10', 'forms_id' => @form.id})
      @result2 = Result.create(:forms_id => @form.id, :jsondata => {'Name' => 'Nabeel2', 'Length Of Stay' => '12', 'forms_id' => @form.id})
    end

    it 'should display the form given the formID ' do
      post :showform, {'formid' => @form.id}
      expect(response).to render_template('showform')
    end

    it 'should display the form given the formID and pagination next attributes ' do
      post :showformnext, {'formid' => @form.id, 'pagination' => 'next'}
      expect(response).to render_template('showform')
    end

    it 'should display the form given the formID and pagination next attributes ' do
      post :showformnext, {'formid' => @form.id, 'pagination' => 'previous'}
      expect(response).to render_template('showform')
    end

    it 'show all the archieved forms ' do
      get :showarchiveform, {'formid' => @form.id}

      expect(response).to render_template('showarchiveform')
      expect(response.body).to include("testForm Data : Archived")
    end
  end


  describe 'should display the form given the  ' do

    before(:each) do
      @project = Project.create(:project_name => 'test project', :research_group => 'epidimiology', :researchers_id => '1')
      @form = Form.create(:form_name => 'testForm', :projects_id => @project.id, :archive => false )
      @formattributes1 = Formattribute.create(:column_name => 'Name', :column_type => 'String', :forms_id => @form.id)
      @formattributes2 = Formattribute.create(:column_name => 'Length Of Stay', :column_type => 'Integer', :forms_id => @form.id)
      @formattributes3 = Formattribute.create(:column_name => 'Disease', :column_type => 'Categorical', :forms_id => @form.id)
      @result1 = Result.create(:forms_id => @form.id, :jsondata => {'Name' => 'Nabeel', 'Length Of Stay' => '10', 'formID' => @form.id, 'Disease' => 'cat1'})
      @result2 = Result.create(:forms_id => @form.id, :jsondata => {'Name' => 'Nabeel', 'Length Of Stay' => '10', 'formID' => @form.id, 'Disease' => 'cat2'})
    end

    it 'archive the form' do
      post :archiveform, {:formid => @form.id}

      expected = {'success' => true}.to_json
      response.header['Content-Type'].should include 'application/json'
      expect(response.body).to eq(expected)
    end

    it 'search result ' do
      post :search, {:formid => @form.id, :columnname => 'Name', :search => 'Nabeel'}

      expected = @result1.to_json
      response.header['Content-Type'].should include 'application/json'
      expect(response.body).to include('Nabeel')
    end

    it 'test file download ' do
      get :export, {:formid => @form.id}
      response.header['Content-Type'].should include 'text/plain'
    end

    it 'should render categorical view ' do
      get :categorical_charts, {:format => @form.id}

      expect(response).to render_template('categorical_charts')
    end
  end
end
