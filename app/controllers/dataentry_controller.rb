

class DataentryController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_current_user

  def signuppage
    # Renders views/dataentry/signuppage.html.haml
  end

  def createDataEntry
    if params['password'] == params['confirmpassword']

      authenticationAttributes = {
        email: params['email'],
        password: Digest::MD5.hexdigest(params['password']),
        usertype: "dataentry"
      }

      if Authentication.find_by_email(params[:email])
        flash[:notice] = 'Error, User already Exists'
        flash[:success] = 0
        redirect_to '/dataentry/signup'
      else
        user = AuthenticationController.createuser(authenticationAttributes)
        if !user
          flash[:notice] = 'Error, User cannot be created'
          redirect_to '/researcher/signup'
        else
          dataentryattributes = {
            firstname: params['firstname'],
            lastname: params['lastname'],
            :profile => params['profile'],
            :institution => params['institution'],
            authentications_id: user.id
          }
          dataEntry = Dataentry.create_dataentry(dataentryattributes);
          if !dataEntry
            #TODO: Rollback User creation in last step
            flash[:notice] = "Error, User cannot be created"
            redirect_to '/dataentry/signup'
          else
            session[:session_token] = user.session_token
            session[:usertype] = user.usertype
            # session[:firstname] = dataEntry.firstname
            flash[:success] = 1
            flash[:notice] = "User is Successfully Created, Logged in"
            redirect_to '/dataentry/dataentry_landing_page'
          end
        end
      end


    else
      flash[:notice] = "Passwords not matching"
      flash[:success] = 0
      redirect_to '/dataentry/signup/'
    end
  end

  # def login
  #   user = Authentication.find_by(params['email'])
  #   if user and (Digest::MD5.hexdigest(params['password']) == user.password)
  #
  #     print "\n USER SESSION TOKEN IS ", user.session_token
  #     print "\n SESSION VARIABLE BEFORE IS ", session[:session_token]
  #     session[:session_token] = user.session_token
  #     print "\n SESSION VARIABLE AFTER IS ", session[:session_token]
  #
  #     session[:usertype] = user.usertype
  #     flash[:notice] = "User logged In"
  #     redirect_to '/dataentry/dataentry_landing_page'
  #   else
  #     flash[:notice] = "Email or Password wrong!!!"
  #     redirect_to '/login'
  #   end
  # end

  def update

    if @usertype == 'dataentry'
      dataentry = Dataentry.find_by_authentications_id(@id)
      dataentry.firstname = params['firstname']
      dataentry.lastname = params['lastname']
      dataentry.profile = params['profile']
      dataentry.institution = params['institution']
      dataentry.save
      redirect_to '/profile'
      #TODO: Update the flash message to show that the profile is updated or not.
    else
      redirect_to '/'
    end
  end

  def getallusers
    users = Dataentry.all
    msg = users.as_json
    render :json => msg
  end

  def displayform
    formID = params[:formid]
    print "\n Form id is ", formID
    @form = Form.find(formID)
    print "Fomr name is ",@form.form_name

    @formAttributes = Formattribute.where(:forms_id => formID)
    @categoricalAttr = {}
    @stringAttr = {}
    @integerAttr = {}
    @dateAttr = {}

    @formAttributes.each do |formattr|
      print "Form attributes are ", formattr.column_name
      if formattr.column_type == "Categorical"
        formAttrID = formattr.id
        @categoricalAttr[formattr.column_name] = Categoricalformattribute.where(:formattributes_id => formAttrID)
      end
      if formattr.column_type == "String"
        formAttrID = formattr.id
        stringAttr = Categoricalformattribute.where(:formattributes_id => formAttrID)
        stringAttr.each do |attr|
          if attr.name == 'length'
            @stringAttr[formattr.column_name] = attr.option
          end
        end
      end
      if formattr.column_type == "Integer"
        formAttrID = formattr.id
        minLength = Categoricalformattribute.where(:formattributes_id => formAttrID, :name => 'minlength')
        maxLength = Categoricalformattribute.where(:formattributes_id => formAttrID, :name => 'maxlength')
        minLength.each do |len1|
          if len1.name == 'minlength'
            maxLength.each do |len2|
              if len2.name == 'maxlength'
                @integerAttr[formattr.column_name] = [len1.option, len2.option]
              end
            end
          end
        end
      end
      if formattr.column_type == "Date"
        formAttrID = formattr.id
        minDate = Categoricalformattribute.where(:formattributes_id => formAttrID, :name => 'mindate')
        maxDate = Categoricalformattribute.where(:formattributes_id => formAttrID, :name => 'maxdate')
        minDate.each do |date1|
          if date1.name == 'mindate'
            maxDate.each do |date2|
              if date2.name == 'maxdate'
                @dateAttr[formattr.column_name] = [date1.option, date2.option]
              end
            end
          end
        end
      end
    end

    print "\n Categorical Attr are", @categoricalAttr
    print "\n Integer Attr are", @integerAttr
    print "\n Date Attr are", @dateAttr
    print "\n String Attr are", @stringAttr
    render 'dataentry/displayform'
  end

  def updatepage
    if @usertype == 'dataentry'
      dataentryuser = Dataentry.find_by_authentications_id(@id)

      if dataentryuser
        id = dataentryuser.id
        formAccess = Formsaccess.all.where(:dataentries_id => id)

        @forms = []
        print "length of form are ",formAccess.length
        formAccess.each do |access|
          form = Form.find(access.forms_id)
          print "\n Form are ", form.id, form.form_name
          @forms.append(form)
        end

        render '/dataentry/update'
      else
        redirect_to '/login'
      end
    else
      redirect_to '/login'
    end
  end

  def getrecordstoupdate
    print "\n params received are ",params
    formID = params['form']

    data = Resultsstaging.where(:forms_id => formID, :updateneeded => true)

    msg = data.as_json
    render :json => msg
  end

  def getformtoedit
    print "\n Params to get form to edit are", params

    formID = params['form']

    @formtoedit = Form.find(formID)
    print "Fomr name is ",@formtoedit.form_name

    data = Formattribute.where(:forms_id => formID)
    # @formEditAttr.each do |formattr|
    #   print "Form attributes are ", formattr.column_name
    # end
    msg = data.as_json
    render :json => msg

  end

  def updateformdata

    print "\n Params for form edit are", params
    record = Resultsstaging.find(params['resultid'])
    attributes = Formattribute.where(forms_id: params['formid'])

    updatedJson = {}

    attributes.each do |attr|
      updatedJson[attr.column_name] = params[attr.column_name]
    end

    record.jsondata = updatedJson
    record.updateneeded = false

    record.save()

    redirect_to '/dataentry/update'
  end

end
