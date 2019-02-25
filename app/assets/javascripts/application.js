// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require Chart.bundle
//= require chartkick

//= require_tree .




var id = 2;
var row = null;

$(document).on("click", ".btn-add-row", function () {
  row = $(".rowtocreateform:last-child").clone().show();
  row.attr("id", "field" + id);
  $(".element-wrapper").append(row);

  $("#field"+id).find("Categorical").remove();

  $(".rowtocreateform:last-child > .row > .col-md-6 > .form-group > .form-control").attr("id", "formfield" + id);
  $(".rowtocreateform:last-child > .row > .col-md-2 > .form-group > .form-control").attr("id", "field" + id + "type");

  $(".rowtocreateform:last-child > .attributecategory").remove();

  $(".rowtocreateform:last-child > .row > .col-md-6 > .form-group > .form-control").attr("name", "formfield" + id);
  $(".rowtocreateform:last-child > .row > .col-md-2 > .form-group > .form-control").attr("name", "formfield" + id + "type");
  $(".rowtocreateform:last-child > .row > .col-md-2 > .form-group > .form-button").attr("id", "field" + id);
  $(".rowtocreateform:last-child > .row > .col-md-2 > .form-group > .form-button").attr("type", "button");

  $(".rowtocreateform:last-child > .row > .col-md-6 > .form-group > .form-control").val('')

  newID = "field" + id
  preCategory = 'category'+newID
  categoryID = newID + 'category'
  row = "<div id='"+categoryID+"' class='attributecategory'><pre id='"+preCategory+"'> &nbsp;&nbsp;Length<input type='number' name='form"+id+"length' min='0' max='10' required></pre></div>"
  $('#'+newID).append(row);

  console.log("ID in function ", id);

  id++;
});


$("#projectselector").load(function () {
  if($(this).val()== 'Select Project'){
    $("#remainingform").hide();
    $("#addfieldbutton").hide();
  }
  else{
    $("#remainingform").show();
    $("#addfieldbutton").show();
  }
})

$("#projectselector").change(function () {
  if($(this).val()== 'Select Project'){
    $("#remainingform").hide();
    $("#addfieldbutton").hide();
  }
  else{
    $("#remainingform").show();
    $("#addfieldbutton").show();
  }
})


$(document).ready(function () {
  $("#remainingform").hide();
  $("#addfieldbutton").hide();
  // id = 2;
  // console.log("ID is ", id);
});


function deleteColumn(id){
  console.log("ID is ",id)
  if (id != "field1"){
    $("#"+id).remove()
  }
}


// Adding Forms Field when adding new form
$('#projectselectoraccess').change(function () {
  $('#formselectoraccess').remove()
  console.log("Value ",$(this).val())
  if ($(this).val() == "Select project"){
    $('#formselectoraccess').remove()
    $('#projects').remove()
  }
  else{
    $.ajax({
      url: "/form/getforms",
      type: "POST",
      data: {"project" : $(this).val()},
      dataType: "json",
      success: function(data) {
        console.log("Data is ")
        console.log(data)
        var formselector = "<div id='formselectoraccess'><br><h4>Select Form</h4><select id='formselector' name='form' onchange='displayusers()'> <option value='nil'> Select Form</option>"

        if (data.length == undefined){
          var temp = "<option value='"+data.id+"'>"+data.form_name+"</option>"
          formselector += temp;
        }
        else{
          for (i=0; i < data.length; i++){
            var temp = "<option value='"+data[i].id+"'>"+data[i].form_name+"</option>"
            formselector += temp;
          }
        }

        formselector += "</select></div>";
        $('#addnewform').append(formselector);
      }
    });
  }
});


function displayusers(){
  console.log("alert")
  $('#projectsusers').remove()
  $.ajax({
    url: "/formaccess/getformsuser",
    type: "POST",
    // data: {"project" : $('#projectselectoraccess').val(), "form" : $('#formselector').val()},
    data: {"form" : $('#formselector').val()},
    dataType: "json",
    success: function(data) {
      console.log("Data Entry Data Received is ", data)
      dataEntryId = []
      if (data.length == undefined){
        dataEntryId += data.dataentries_id;
      }
      else{
        for(i=0; i <data.length; i++){
          dataEntryId += data[i].dataentries_id;
        }
      }

      console.log("Dataentry IDs are ",dataEntryId)

      $.ajax({
        url: "/dataentry/allusers",
        type: "POST",
        data: {},
        dataType: "json",
        success: function(data) {
          console.log("Data Entry Users", data)
          var table = "<div id='projectsusers'><br><h3>Users</h3><table id='projects'><thead><tr><th> FirstName </th><th> LastName </th><th> Profile </th><th> Institution </th><th>Grant Access</th></tr></thead><tbody>"
          for(i=0; i<data.length; i++){
            var checked = 'unchecked';
            if ($.inArray(data[i].id.toString(), dataEntryId) != -1){
              console.log("Changed to checked");
              checked = "checked"
            }
            table += "<tr> <td><a href='#'>" + data[i].firstname + "</a></td>"
            table += "<td>" + data[i].lastname + "</td>"
            table += "<td>" + data[i].profile + "</td>"
            table += "<td>" + data[i].institution + "</td>"
            table += "<td><input type='checkbox' name='dataentry_id[]' value='"+data[i].id+"' "+checked+">  </td> </tr>"
          }
          table += "</tbody></table>";
          table += "<br><button class='btn btn-primary' type='submit' value='submit'>Update</button></div>"
          console.log("Table is ", table)
          $('#formselectoraccess').append(table);
        }
      });
    }
  });
}

function checkcategorical(id){
  console.log("Check Categorical Function called, ID: ",id);
  newID = id.replace("type", "");
  preCategory = 'category'+newID
  if ($('#'+id).val() == "Categorical"){
    console.log("Categorical values selected");

    // To remove the existing attributes
    $('#'+newID+"category").remove();

    fieldName = "form" + newID + "category"
    categoryID = newID + 'category'

    row = " <div class='attributecategory' id='" + categoryID + "'> <pre id='"+preCategory+"'>&nbsp;&nbsp; Categorical Variable : <input type='text' name='" + fieldName + "[]' required> </pre> <a id='"+categoryID+"' href='javascript:void(0)' onclick='addMoreCategories(this.id, newID)'> Add More Categories </a> <br></div>";

    $('#'+newID).append(row);
    console.log("Row appended", newID, "category id is ", categoryID, " newID is", newID);
  }

  if ($('#'+id).val() == "Integer"){
    console.log("In integer ID received is ", id);
    // $(id+'category').remove();
    newID = id.replace("type", "");
    $('#'+newID+"category").remove();
    categoryID = newID + 'category'
    row = "<div id='"+categoryID+"' class='attributecategory'> <pre id='"+preCategory+"'> &nbsp;&nbsp;Min<input type='number' name='form"+id+"min' min='1' max='2147483647' required> Max<input type='number' name='form"+id+"max' min='1' max='2147483647' required></pre></div>"
    $('#'+newID).append(row);
  }

  if ($('#'+id).val() == "Date"){
    console.log("In integer ID received is ", id);
    // $(id+'category').remove();
    newID = id.replace("type", "");
    $('#'+newID+"category").remove();
    categoryID = newID + 'category'
    row = "<div id='"+categoryID+"' class='attributecategory'> <pre id='"+preCategory+"'> &nbsp;&nbsp;Start Date<input type='date' name='form"+id+"mindate' required> End Date<input type='date' name='form"+id+"maxdate' required></pre></div>"
    $('#'+newID).append(row);
  }

  if ($('#'+id).val() == "String"){
    console.log("In integer ID received is ", id);
    // $(id+'category').remove();
    newID = id.replace("type", "");
    $('#'+newID+"category").remove();
    categoryID = newID + 'category'
    row = "<div id='"+categoryID+"' class='attributecategory'> <pre id='"+preCategory+"'> &nbsp;&nbsp;Length<input type='number' name='form"+id+"length' min='1' max='100' required></pre></div>"
    $('#'+newID).append(row);
  }
}

function addMoreCategories(receivedID, rowID){
  rowID = receivedID.replace("category", "");
  console.log("Add more categories function callled with id ", receivedID, rowID);
  var newRow = "<br>&nbsp;&nbsp;&nbsp;Categorical Variable : <input type='text' name='" + fieldName + "[]' required/>"

  row = $('#category'+rowID).append(newRow);
}


function archiveForm(message, formID){
  alert(message);
  console.log("Delete this Form ID ", formID);
  $.ajax({
    url: "/form/archiveform",
    type: "POST",
    data: {formid : formID},
    dataType: "json",
    success: function(data) {
      console.log("Form archieved ", data)
      window.location = "/researcher/researcher_landing_page";
    }
  });
}

function archiveProject(message, projectID){
  alert(message);
  console.log("Delete this Project ID ", projectID);
  $.ajax({
    url: "/project/archiveproject",
    type: "POST",
    data: {projectid : projectID},
    dataType: "json",
    success: function(data) {
      console.log("Form archieved ", data)
      window.location = "/researcher/researcher_landing_page";
    }
  });
}







