
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///showform.js
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// function search(formID){
$('#searchkeyword').keypress(function () {
  attribute = $('#searchattribute').val();
  keyword = $('#searchkeyword').val();
  formID = $('#formID').text();
  console.log("Search keyword called ");
  console.log("Column atteibute is ", attribute);
  console.log("Search Keyword is ", keyword);
  console.log("Form ID is ", formID);
  $.ajax({
    url: "/forms/search",
    type: "POST",
    data: {
      "formid": formID,
      "columnname" : attribute,
      "search": keyword
    },
    dataType: "json",
    success: function (data) {
      console.log("Form Data is ")
      console.log(data);
      $('#formsbody').remove();
      formColumn = $('#formscolumn').text();
      formColumn = formColumn.split("\n");
      formColumn.splice(0, 1);
      formColumn.splice(formColumn.length-1, 1);

      console.log("Forms data is ", formColumn);

      var tableBody = "<tbody id='formsbody'>";
      // Object.entries(data).forEach(([key, value]) => {
      $.each(data, function(key, value) {
        // do something with key and val
        console.log("IN 1")
        // Object.entries(value).forEach(([key2, value2]) => {
        $.each(value, function(key2, value2) {
          console.log("IN 2")
          if (key2 == 'jsondata'){
            tableBody += "<tr>"
            console.log("IN 3")
            for(i=0; i<formColumn.length; i++){
              console.log("IN 4")
              tableBody += "<td>" + value2[formColumn[i]] + "</td>>"
            }
            tableBody += "</tr>"
          }
        });
      });
      tableBody += "</tbody>"
      console.log("Data is ",tableBody);
      $('#forms').append(tableBody);
    }
  });
});
