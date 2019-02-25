////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///dataentryupdate.js
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var count = 0

$("#selectedform").change(function () {

  console.log("Value ",$(this).val())

  if (count != 0){
    console.log("count ",count)
    $('#editdata').remove();
  }

  console.log("In else ")
  $.ajax({
    url: "/dataentry/getrecordstoupdate",
    type: "POST",
    data: {"form": $(this).val()},
    dataType: "json",
    success: function (data) {
      console.log("Form Data is ")
      console.log(data)
      formData = data
      var table = "<div id='editdata'><br>" +
        "<h4>Data</h4>" +
        "<table id='projects'>" +
        "<thead>" +
        "<tr>" +
        "<th> FormID </th>" +
        "<th> Created At </th>" +
        "<th> Updated At </th>" +
        "<th> Edit </th>" +
        "</tr>" +
        "</thead>" +
        "<tbody>"
      for (i = 0; i < data.length; i++) {
        table += "<tr id='row" + data[i].id + "'> <td><a href='#'>" + data[i].forms_id + "</a></td>"
        table += "<td>" + data[i].created_at + "</td>"
        table += "<td>" + data[i].updated_at + "</td>"
        table += "<td align='center' id=" + data[i].id + "> " +
          "<a href='#' data-toggle=\"modal\" data-target=\"#editDataModal\" onclick='loadForm(" + i + ")'>Edit Data</a> " +
          "</td>"
      }
      table += "</tbody></table>";
      table += "</div>"

      $('#updatedataform').append(table);
      count += 1;
    }
  });
});

function loadForm(index){
  console.log("ID received is ", index)
  console.log("Form id is ", $("#selectedform").val())
  $.ajax({
    url: "/dataentry/getformtoedit",
    type: "POST",
    data: {"form" : $("#selectedform").val()},
    dataType: "json",
    success: function(attributeData) {
      $('#editDataPostForm').empty();
      console.log("Form Data is ")
      console.log(attributeData)

      var resultID = formData[index].id
      var formID = $('#selectedform').val()

      console.log("ResultID is" +resultID)

      for(i=0; i<attributeData.length; i++){
        var form = "<div class='form-group'>" +
          attributeData[i].column_name +
          "<input class='form-control' " +
          "name='"+attributeData[i].column_name+"' type='"+attributeData[i].column_type+"' value='"+formData[index].jsondata[attributeData[i].column_name]+"'>" +
          "</div>"
        $('#editDataPostForm').append(form);
        console.log(attributeData[i]);
      }
      var input = "<input type='hidden' name='resultid' value='"+resultID+"'>"
      input += "<input type='hidden' name='formid' value='"+formID+"'>"
      $('#editDataPostForm').append(input);
      var submit = "<button type='submit' class='btn btn-primary'>Update Record</button>"
      $('#editDataPostForm').append(submit);
    }
  });
}
