require 'spec_helper'
require 'rails_helper'

describe ProjectsController do
  describe 'Add new project' do
    it 'should ser researchers id' do
      @user = Authentication.create(:email => 'testresearcher@email.com', :password => Digest::MD5.hexdigest('1234'), :session_token=>'1234' , :usertype => 'researcher', :access =>'user')
      @ruser = Researcher.create(:firstname =>'testfirst', :lastname => 'testsecond', :researchgroup => 'testgroup', :authentications_id => @user.id)
    end
    it 'should create project' do
      mock_return = double('project_double')
      allow(mock_return).to receive(:project_name).and_return("fake project name")
      expect(controller).to receive(:set_researcher_id).and_return(1)
      expect(Project).to receive(:create!).with({project_name: 'Example Name', research_group: 'Example Group', researchers_id: 1})
                           .and_return(mock_return)
      post :create, {project_name: 'Example Name', research_group: 'Example Group', researchers_id: 1}
    end
    it 'rendering of index page' do
      get :index
      expect(response).to render_template('projects/index')
    end
  end

  describe 'show projects' do
    it 'should return user projects if the user is researcher' do
      @user = Authentication.create(:email => 'testresearcher@email.com', :password => Digest::MD5.hexdigest('1234'), :session_token=>'1234' , :usertype => 'researcher', :access =>'user')
      @ruser = Researcher.create(:firstname =>'testfirst', :lastname => 'testsecond', :researchgroup => 'testgroup', :authentications_id => @user.id)
      @project = Project.create(:project_name => 'testproject', :research_group => 'testgroup', :researchers_id => @ruser.id)
      session[:session_token] = '1234'
      session[:usertype] = 'researcher'
      get :show,{'id'=> @project.id}
    end
    it 'should redirect to login if the user is not researcher' do
      @user = Authentication.create(:email => 'testresearcher@email.com', :password => Digest::MD5.hexdigest('1234'), :session_token=>'1234' , :usertype => 'researcher', :access =>'user')
      @ruser = Researcher.create(:firstname =>'testfirst', :lastname => 'testsecond', :researchgroup => 'testgroup', :authentications_id => @user.id)
      @project = Project.create(:project_name => 'testproject', :research_group => 'testgroup', :researchers_id => @ruser.id)

      session[:session_token] = nil
      get :show,{'id'=> @project.id}
      expect(response).to redirect_to('/login')
    end
  end

  describe 'archive project' do
    it 'should archive a project and return a JSON format data' do
      @user = Authentication.create(:email => 'testresearcher@email.com', :password => Digest::MD5.hexdigest('1234'), :session_token=>'1234' , :usertype => 'researcher', :access =>'user')
      @ruser = Researcher.create(:firstname =>'testfirst', :lastname => 'testsecond', :researchgroup => 'testgroup', :authentications_id => @user.id)
      @project = Project.create(:project_name => 'testproject', :research_group => 'testgroup', :researchers_id => @ruser.id)
      @form = Form.create(:form_name => 'testform', :projects_id => @project.id)

      get :archiveproject,{'projectid' => @project.id}
      response.header['Content-Type'].should include 'application/json'
    end
  end
end
