class ResearcherController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_current_user
  respond_to :json, :html

  def signuppage
    # Renders views/researcher/signuppage.html.haml
  end

  def createResearcher
    if params['password'] == params['confirmpassword']

      authenticationAttributes = {
        email: params['email'],
        password: Digest::MD5.hexdigest(params['password']),
        usertype: 'researcher'
      }
      if Authentication.find_by_email(params['email'])
        flash[:notice] = 'Error, User already Exists'
        flash[:success] = 0
        redirect_to '/researcher/signup'
      else
        user = AuthenticationController.createuser(authenticationAttributes)
        if !user
          flash[:notice] = 'Error, User cannot be created'
          redirect_to '/researcher/signup'
        else
          researcherAttributes = {
            firstname: params['firstname'],
            lastname: params['lastname'],
            researchgroup: params['researchgroup'],
            authentications_id: user.id
          }
          researcher = Researcher.create_researcher(researcherAttributes)
          if !researcher
            #TODO: Roll Back User Creation in last step
            flash[:notice] = 'Error, User cannot be created'
            flash[:success] = 0
            redirect_to '/researcher/signup'
          else
            flash[:notice] = 'User is Successfully Created, Logged In'
            flash[:success] = 1
            # session[:firstname] = researcher.firstname
            session[:session_token] = user.session_token
            session[:usertype] = user.usertype
            redirect_to '/researcher/researcher_landing_page'
          end
        end
      end
    else
      flash[:notice] = 'Passwords not matching'
      redirect_to '/researcher/signup/'
    end
  end

  def researcher_landing_page
    if session[:session_token] and (session[:usertype] == 'researcher')
      # Renders views/researcher/researcher_landing_page.html.haml
      id = Researcher.find_by_authentications_id(@id).id
      @projects = Project.all.where(researchers_id: id, archive: false)
      @project = Project.all.where(researchers_id: id)
    else
      redirect_to '/'
    end
  end

  def update
    if @usertype == 'researcher'
      researcher = Researcher.find_by_authentications_id(@id)
      researcher.firstname = params['firstname']
      researcher.lastname = params['lastname']
      researcher.researchgroup = params['researchgroup']
      researcher.save
      redirect_to '/profile'
      #TODO: Update the flash message to show that the profile is updated or not.
    else
      redirect_to '/'
    end
  end

  def generateform
    researcher = Researcher.find_by_authentications_id(@id)
    if researcher
      id = researcher.id
      print "\n RESEARCHER ID ", researcher.id
      @project = Project.all.where(:researchers_id => id)
      render '/researcher/generateform'
    else
      redirect_to '/researcher/researcher_landing_page'
    end
  end

  def createform
    print "\n PARAMS RECEIVED"
    print "\n PARAMS ", params
    form = {}
    form['projects_id'] = params['project']
    form['form_name'] = params['formname']

    # TODO: Create some mechanism for error handling, if record creation throws some error:
    formcreated = Form.create(form)

    params.each do |key, value|
      formattr = {}
      string = false
      integer = false
      date = false
      if key.include? "formfield" and !key.include? "type" and !key.include? "category"
        formattr['forms_id'] = formcreated.id
        formattr['column_name'] = params[key]
        formattr['column_type'] = params[key+"type"]
        formattr['categorical'] = false
        if formattr['column_type'] == "Categorical"
          formattr['categorical'] = true
        end
        if formattr['column_type'] == "String"
          string = true
        end
        if formattr['column_type'] == "Integer"
          integer = true
        end
        if formattr['column_type'] == "Date"
          date = true
        end


        # TODO: Create some mechanism for error handling, if record creation throws some error:
        formAttr = Formattribute.create(formattr)
        if formAttr
          if formattr['categorical'] == true
            params[key+"category"].each do |cat|
              categoricalFormAttr = {}
              categoricalFormAttr['formattributes_id'] = formAttr.id
              categoricalFormAttr['option'] = cat
              categoricalFormAttr['name'] = 'categorical'
              Categoricalformattribute.create(categoricalFormAttr)
            end
          elsif string == true
            categoricalFormAttr = {}
            categoricalFormAttr['formattributes_id'] = formAttr.id
            categoricalFormAttr['option'] = params[key+'typelength']
            categoricalFormAttr['name'] = 'length'
            Categoricalformattribute.create(categoricalFormAttr)
          elsif integer == true
            categoricalFormAttr = {}
            categoricalFormAttr['formattributes_id'] = formAttr.id
            categoricalFormAttr['option'] = params[key+'typemin']
            categoricalFormAttr['name'] = 'minlength'
            Categoricalformattribute.create(categoricalFormAttr)
            categoricalFormAttr = {}
            categoricalFormAttr['formattributes_id'] = formAttr.id
            categoricalFormAttr['option'] = params[key+'typemax']
            categoricalFormAttr['name'] = 'maxlength'
            Categoricalformattribute.create(categoricalFormAttr)
          elsif date == true
            categoricalFormAttr = {}
            categoricalFormAttr['formattributes_id'] = formAttr.id
            categoricalFormAttr['option'] = params[key+'typemindate']
            categoricalFormAttr['name'] = 'mindate'
            Categoricalformattribute.create(categoricalFormAttr)
            categoricalFormAttr = {}
            categoricalFormAttr['formattributes_id'] = formAttr.id
            categoricalFormAttr['option'] = params[key+'typemaxdate']
            categoricalFormAttr['name'] = 'maxdate'
            Categoricalformattribute.create(categoricalFormAttr)
          end
          flash[:notice] = "Form successfully added"
          flash[:success] = 1
        else
          flash[:notice] = "Form cannot be added"
          flash[:success] = 1
        end
      end
    end

    redirect_to '/researcher/researcher_landing_page'
  end

  def grantaccess
    id = Researcher.find_by_authentications_id(@id).id
    @project = Project.all.where(researchers_id: id)
    project_name = []
    @project.each do |project|
      project_name.append(project.project_name)
    end
    render '/researcher/grantaccess'
  end

  def approvedata
    id = Researcher.find_by_authentications_id(@id).id
    @project = Project.all.where(researchers_id: id)
  end

  def updateresults
    resultStaginObj = Resultsstaging.find(params['resultstagingID'])
    resultObj = Result.new
    resultObj[:jsondata] = resultStaginObj.jsondata
    resultObj[:forms_id] = resultStaginObj.forms_id
    resultObj.save
    resultStaginObj.delete

    returnObj = {:update => true}
    msg = returnObj.as_json
    render :json => msg
  end

  def deletedata
    resultStaginObj = Resultsstaging.find(params['resultstagingID'])

    resultStaginObj.delete

    returnObj = {:update => true}
    msg = returnObj.as_json
    render :json => msg
  end

  def editdata
    resultStaginObj = Resultsstaging.find(params['resultstagingID'])
    resultStaginObj.updateneeded = true
    resultStaginObj.save

    returnObj = {:update => true}
    msg = returnObj.as_json
    render :json => msg
  end

  def archive
    researcher = Researcher.find_by_authentications_id(@id)
    project = Project.where(:researchers_id => researcher.id)
    projectIDs = []
    project.each do |proj|
      projectIDs.append(proj.id)
    end
    print "\n Project aID are",projectIDs
    @archive = Form.where('projects_id': projectIDs, 'archive': true)
    print "\nLENGTH OF FORMS ARE ",@archive.length
  end
end
