class FormaccessController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_current_user
  respond_to :json, :html

  def getformsuser
    if params['form']
      @user = Formsaccess.where(forms_id: params['form'])
      msg = @user.as_json
      render :json => msg
    else
      msg = {}
      render :json => msg
    end
  end

  def displaydataentryforms
    if @usertype == 'dataentry'
      dataentryuser = Dataentry.find_by_authentications_id(@id)

      if dataentryuser
        id = dataentryuser.id
        @formid = Formsaccess.where(:dataentries_id => id)

        @formsdata = []

        if @formid
          # Rendering all forms and project in one hash file
          @formid.each do |fid|
            temp = {}
            print "\n FORM ID IS ",fid.forms_id
            formObject = Form.find(fid.forms_id)
            projectObject = Project.find(formObject.projects_id)
            temp['form_name'] = formObject.form_name
            temp['project_name'] = projectObject.project_name
            temp['fid'] = fid.forms_id
            @formsdata.append(temp)
          end
        end
        render '/dataentry/dataentry_landing_page'
      else
        redirect_to '/login'
      end
    else
      redirect_to '/login'
    end
  end

  def updateformaccess
    Formsaccess.where(:forms_id => params['form']).destroy_all

    print "\n All the form entries destroyed"
    if params['dataentry_id'] and params['dataentry_id'].length > 0
      params['dataentry_id'].each do |dataentryid|
        formaccess = Formsaccess.new
        formaccess.forms_id = params['form']
        formaccess.dataentries_id = dataentryid
        formaccess.save
      end
    end

    flash[:notice] = "Form Access Updated"
    redirect_to '/researcher/researcher_landing_page'
  end

end
