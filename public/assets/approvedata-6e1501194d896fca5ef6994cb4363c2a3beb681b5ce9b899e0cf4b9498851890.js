////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///approvedata.js
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$("#approvedataprojectselector").load(function () {
  if($(this).val() == 'Select Project'){
    $("#remainingform").hide();
    $("#addfieldbutton").hide();
  }
  else{
    $("#remainingform").show();
    $("#addfieldbutton").show();
  }
})

$("#approvedataprojectselector").change(function () {
  $('#formselectapprovedata').remove()
  console.log("Value ",$(this).val())
  if ($(this).val() == "Select project"){
    $('#approvedataformselector').remove()
    $('#projects').remove()
  }
  else{
    $.ajax({
      url: "/form/getforms",
      type: "POST",
      data: {"project" : $(this).val()},
      dataType: "json",
      success: function(data) {
        console.log("Form Data is ")
        console.log(data)
        var formselector = "<div id='formselectapprovedata'><br>" +
          "<h4>Select Form</h4>" +
          "<select id='approvedataformselector' name='form' onchange='getdataresults()'> " +
          "<option value='nil'> Select Form</option>"

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
})

function getdataresults(){
  $('#approvedata').remove()
  console.log("function loaded ")
  $.ajax({
    url: "/researcher/getdata",
    type: "POST",
    data: {"formid" : $('#approvedataformselector').val()},
    dataType: "json",
    success: function(data) {
      console.log("Data to be approved", data)
      globalRowData = data
      var table = "<div id='approvedata'><br>" +
        "<h4>Data</h4>" +
        "<table id='projects'>" +
        "<thead>" +
        "<tr>" +
        "<th> FormID </th>" +
        "<th> Value </th>" +
        "<th width='30%' align='center'> Approve </th>" +
        "</tr>" +
        "</thead>" +
        "<tbody>"
      for(i=0; i<data.length; i++){
        // Object.entries(data[i].jsondata).forEach(([key, value]) => {
        $.each(data[i].jsondata, function(key, value) {
          console.log("Key - Value  ",key, value )
        });
        table += "<tr id='row"+data[i].id+"'> <td><a href='#'>" + data[i].forms_id + "</a></td>"
        table += "<td>" + "<a class='nav-link' href='' data-target='#dataApprovalModal' data-toggle = 'modal' onclick='showDataOverlay("+i+")'>View Data</a></td>"
        if (data[i].updateneeded == true){
          table += "<td align='center' id="+ data[i].id+"> <a href='#'>Asked For Update</a> </td>"
        }
        else{
          table += "<td align='center' id="+ data[i].id+">" + "<button class='btn btn-success' onclick='approveData("+data[i].id+")'>Approve</button> <button class='btn btn-danger' onclick='deleteData("+data[i].id+")'>Delete</button> <button class='btn btn-primary' onclick='editData("+data[i].id+")'>Edit</button>"  + "</td>"
        }
      }
      table += "</tbody></table>";
      table += "</div>"
      console.log("Table is ", table)
      $('#formselectapprovedata').append(table);
    }
  });
}

function showDataOverlay(index){
  console.log("Data is ", index);
  console.log("Global data is ", globalRowData[index].jsondata);
  $('#viewRowData').empty()

  var data = "<table id='projects'>" +
    "<thead>" +
    "<tr>" +
    "<th> " + "Key" + " </th>" +
    "<th> " + "Value" + " </th>" +
    "</tr>" +
    "</thead>" +
    "<tbody>"

  // Object.entries(globalRowData[index].jsondata).forEach(([key, value]) => {
  $.each(globalRowData[index].jsondata, function(key, value) {
    data += "<tr> <td> " + key + " </td>"
    data += " <td> " + value + " </td> </tr>"
  });

  data += "</tbody> </table>"

  $('#viewRowData').append(data)
}

function approveData(resultID) {
  console.log("Approve data ID is ", resultID)
  $.ajax({
    url: "/researcher/approvedata/",
    type: "POST",
    data: {"resultstagingID": resultID},
    dataType: "json",
    success: function (data) {
      // Data Approved, Remove Column from the table
      console.log("Data received is ",data)
      $('#'+resultID).html("Data Approved");
    }
  })
}

function deleteData(resultID){
  console.log("Delete data ID is ",this.id)
  $.ajax({
    url: "/researcher/deletedata",
    type: "POST",
    data: {"resultstagingID": resultID},
    dataType: "json",
    success: function (data) {
      // Data Deleted, Remove Column from the table
      console.log("Data received is ",data);
      $('#'+resultID).html("Data Deleted");
    }
  })
}

function editData(resultID){
  console.log("Edit Data ID is ",this.id)
  $.ajax({
    url: "/researcher/editdata",
    type: "POST",
    data: {"resultstagingID": resultID},
    dataType: "json",
    success: function (data) {
      // Asked for Edit, Update Approve Column with 'Ask for Edit'
      console.log("Data received is ",data);
      $('#'+resultID).html("Ask for Edit");
    }
  })
}
;
