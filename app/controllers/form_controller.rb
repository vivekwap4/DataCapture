class FormController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_current_user
  respond_to :json, :html

  def getforms
    @forms = Form.where(:projects_id => params['project'])

    msg = @forms.as_json
    render :json => msg
  end

  def showform
    offsetParam = 0
    @form = Form.find(params[:formid])
    @project = Project.find(@form.projects_id)
    @attribues = Formattribute.where(forms_id: params[:formid])
    @length = @attribues.length + 1
    @results = Result.where(forms_id: params[:formid]).limit(15).offset(offsetParam)
    result = Result.where(forms_id: params[:formid])
    length = result.length
    if result.length > length
      @previous = 'disabled'
      @next = 'enabled'
    else
      @previous = 'disabled'
      @next = 'enabled'
    end
    session[:offset] = offsetParam
  end

  def showformnext
    if session[:offset]
      offsetParam = session[:offset]
    else
      offsetParam = 0
    end

    if params[:pagination] == 'next'
      result = Result.where(forms_id: params[:formid])
      length = result.length
      if offsetParam+15 <= length
        offsetParam += 15
      end
      @form = Form.find(params[:formid])
      @project = Project.find(@form.projects_id)
      @attribues = Formattribute.where(forms_id: params[:formid])
      @length = @attribues.length + 1
      @results = Result.where(forms_id: params[:formid]).limit(15).offset(offsetParam)
      session[:offset] = offsetParam
      render '/form/showform'
    end
    if params[:pagination] == 'previous'
      if offsetParam-15 >= 0
        offsetParam -= 15
      end
      @form = Form.find(params[:formid])
      @project = Project.find(@form.projects_id)
      @attribues = Formattribute.where(forms_id: params[:formid])
      @length = @attribues.length + 1
      @results = Result.where(forms_id: params[:formid]).limit(15).offset(offsetParam)
      session[:offset] = offsetParam
      render '/form/showform'
    end
  end

  def showarchiveform
    @form = Form.find(params[:formid])
    @project = Project.find(@form.projects_id)
    @attribues = Formattribute.where(forms_id: params[:formid])
    @length = @attribues.length + 1
    @results = Result.where(forms_id: params[:formid])
  end

  def archiveform
    print "\n FormID for archiving form is", params

    Form.where(:id => params['formid']).update_all(archive: true)

    msg = {'success' => true}.as_json
    render :json => msg
  end

  def search
    formID = params['formid']
    attribute = params['columnname']
    keyword = params['search']
    print "\n keyword received are ", formID, attribute, keyword

    # search query to search in the JSON attribute
    returnObj = Result.where("jsondata ->> '"+attribute+"' like '%"+keyword+"%' and jsondata ->> 'formID' = '"+formID+"'").limit(5)

    # Return JSON Object to display in the form
    msg = returnObj.as_json
    print "\n Msg is ",msg
    render :json => msg
  end

  def export

    @form = Form.find(params[:formid])
    @project = Project.find(@form.projects_id)
    @attribues = Formattribute.where(forms_id: params[:formid])
    @length = @attribues.length + 1
    @results = Result.where(forms_id: params[:formid])

    out_file = File.new(@form.form_name + "_Data.txt", "w")

    @string = ""
    @attribues.each do |attr|
      @string = @string + attr.column_name + "\t"
    end
    out_file.puts(@string)

    @string = ""
    @results.each do |result|
      @attribues.each do |attr|
        @string = @string + result.jsondata[attr.column_name] + "\t"
      end
      out_file.puts(@string)
      @string = ""
    end

    send_file out_file

    out_file.close
  end

  def create_graphs
    # Add actions here
    id = Researcher.find_by_authentications_id(@id).id
    @project = Project.all.where(researchers_id: id)
  end

  def categorical_charts
    # Add actions here
    @form = Form.find(params[:format])
    @attributes = Formattribute.where(forms_id: params[:format])
    @results = Result.where(forms_id: params[:format])

    # Collect all categorical or numerical variables in a form in arrays
    @categorical_var = []
    @numerical_var = []
    @attributes.each do |attr|
      if attr.column_type.eql?('Categorical')
        @categorical_var = Array(@categorical_var).push(attr.column_name)
      elsif attr.column_type.eql?('Integer')
        @numerical_var = Array(@numerical_var).push(attr.column_name)
      end
    end

    # Create Hash(es) Array and Hash(es) to Fill Array
    @categorical_var_hash_array = []
    @categorical_var.each do |var|
      temp_hash = Hash.new
      @results.each do |result|
        key_test = result.jsondata[var]
        if temp_hash.has_key?(key_test)
          temp_hash[key_test] += 1
        else
          temp_hash[key_test] = 1
        end
      end
      @categorical_var_hash_array = Array(@categorical_var_hash_array).push(temp_hash)
    end
    # Same hash creation for numerical variables
    @numerical_var_hash_array = []
    @numerical_var.each do |var|
      temp_hash = Hash.new
      @results.each do |result|
        key_test = result.jsondata[var]
        if temp_hash.has_key?(key_test)
          temp_hash[key_test] += 1
        else
          temp_hash[key_test] = 1
        end
      end
      @numerical_var_hash_array = Array(@numerical_var_hash_array).push(temp_hash)
    end

  end

end
