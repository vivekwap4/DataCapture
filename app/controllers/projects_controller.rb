class ProjectsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_current_user

  def new
    # Default new action: renders views/projects/new.html.haml
  end

  def set_researcher_id
    @user = Authentication.find_by_session_token(@session_token)
    researcher = Researcher.find_by_authentications_id(@id)
    researcher.id
  end

  def create
    @user = Authentication.find_by_session_token(@session_token)
    researcher = Researcher.find_by_authentications_id(@id)

    project_params = {
      project_name: params[:project_name],
      research_group: params[:research_group],
      researchers_id: set_researcher_id
    }
    print "Project params are ", project_params
    @project = Project.create!(project_params)
    flash[:notice] = "#{@project.project_name} has been created"
    redirect_to '/researcher/researcher_landing_page'
  end

  def index
    # Renders views/projects/index.html.haml
    @project = Project.all
  end

  def show
    researcher = Researcher.find_by_authentications_id(@id)
    if researcher
      projects = Project.where(researchers_id: researcher.id)
      pass = false
      projects.each do |proj|
        if proj.id.to_s == params[:id]
          pass = true
          break
        end
      end
      if pass
        id = params[:id]
        @project = Project.find(id)
        @forms = Form.all.where(projects_id: id, archive: false)
      else
        @forms = []
      end
    else
      redirect_to '/login'
    end
  end

  def archiveproject
    print"\n Project ID for archiving is ", params

    Form.all.where(:projects_id => params['projectid'], archive: false).update_all(archive: true)
    Project.where(:id => params['projectid']).update_all(archive: true)

    msg = {'success' => true}.as_json
    render :json => msg
  end

end
