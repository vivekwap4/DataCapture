class ResultController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_current_user
  respond_to :json, :html

  def savestagingdata
    formID = params['formId']

    formAttributes = Formattribute.all.where(:forms_id => formID)

    data = {:formID => formID}
    formAttributes.each do |formAttr|
      data[formAttr.column_name] = params[formAttr.id.to_s]
    end

    # Converting Ruby Hashed Object to JSON
    dataJSON = data.to_json

    resultStaging = Resultsstaging.new
    resultStaging[:forms_id] = formID
    resultStaging[:jsondata] = dataJSON

    resultStaging.save

    redirect_to '/dataentry/dataentry_landing_page'
  end

  def getstagingdata
    print "\n Params received for adata approval are ", params

    formattributes = Formattribute.where(:forms_id => params['formid'])
    @resultstaging = []
    @resultstaging = Resultsstaging.where(:forms_id => params['formid'])

    msg = @resultstaging.as_json
    render :json => msg
  end

end
