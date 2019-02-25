# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

researchUser1 = {
  :firstname => "Nabeel",
  :lastname => "khan",
  :researchgroup => "Epidemiology",
  :authentications_id => 1
}

researchauth1 = {
  :email => "nabeelahmadkh@gmail.com",
  :password => "58b4e38f66bcdb546380845d6af27187",
  :usertype => "researcher",
  :access => "user",
  :session_token => "3YpLmgfO8tsd78"
}

researchUser2 = {
  :firstname => "Vivek",
  :lastname => "mishra",
  :researchgroup => "SELT",
  :authentications_id => 2
}

researchauth2 = {
  :email => "vivek@gmail.com",
  :password => "58b4e38f66bcdb546380845d6af27187",
  :usertype => "researcher",
  :access => "user",
  :session_token => "3YpLmgfO8tsdbb6"
}

dataentryUser1 = {
  :firstname => "Rae",
  :lastname => "Corrigan",
  :profile => "BioMedical Researcher",
  :institution => "University of Iowa",
  :authentications_id => 3
}

dataentryauth1 = {
  :email => "rae@gmail.com",
  :password => "58b4e38f66bcdb546380845d6af27187",
  :usertype => "dataentry",
  :access => "user",
  :session_token => "3YpLmgfO8tsdbed3"
}

dataentryUser2 = {
  :firstname => "Nicole",
  :lastname => "Tatro",
  :profile => "BioMedical Researcher",
  :institution => "University of Iowa",
  :authentications_id => 4
}

dataentryauth2 = {
  :email => "nicole@gmail.com",
  :password => "58b4e38f66bcdb546380845d6af27187",
  :usertype => "dataentry",
  :access => "user",
  :session_token => "3YpLmgfO8tsdbed3231"
}

project1 = {
  :project_name => "CDiff",
  :research_group => "Epidimiology",
  :researchers_id => 1
}

form1 = {
  :form_name => "CDiff Patient Form",
  :projects_id => 1
}

formattributes11 = {
  :column_name => "Name",
  :column_type => "String",
  :forms_id => 1
}

formattributes12 = {
  :forms_id => 1,
  :column_name => "Admit Date",
  :column_type => "Date"
}
formattributes13 = {
  :forms_id => 1,
  :column_name => "Discharge Date",
  :column_type => "Date"
}
formattributes14 = {
  :forms_id => 1,
  :column_name => "Length of Stay",
  :column_type => "Integer"
}
formattributes15 = {
  :forms_id => 1,
  :column_name => "Room Number",
  :column_type => "Integer"
}

formattributes11categorical1 = {
  :formattributes_id => '1',
  :option => '10',
  :name => 'length'
}

formattributes11categorical2 = {
  :formattributes_id => '2',
  :option => '2017-01-01',
  :name => 'mindate'
}

formattributes11categorical3 = {
  :formattributes_id => '2',
  :option => '2018-01-01',
  :name => 'maxdate'
}

formattributes11categorical4 = {
  :formattributes_id => '3',
  :option => '2017-01-01',
  :name => 'mindate'
}

formattributes11categorical5 = {
  :formattributes_id => '3',
  :option => '2018-01-01',
  :name => 'maxdate'
}

formattributes11categorical6 = {
  :formattributes_id => '4',
  :option => '0',
  :name => 'minlength'
}

formattributes11categorical7 = {
  :formattributes_id => '4',
  :option => '100',
  :name => 'maxlength'
}

formattributes11categorical8 = {
  :formattributes_id => '5',
  :option => '0',
  :name => 'minlength'
}

formattributes11categorical9 = {
  :formattributes_id => '5',
  :option => '100',
  :name => 'maxlength'
}

form2 = {
  :form_name => "Cdiff Patient Room Allocation Record",
  :projects_id => 1
}

formattributes21 = {
  :forms_id => 2,
  :column_name => "Patient ID",
  :column_type => "Integer"
}
formattributes22 = {
  :forms_id => 2,
  :column_name => "Room Number",
  :column_type => "Integer"
}
formattributes23 = {
  :forms_id => 2,
  :column_name => "Move In",
  :column_type => "Date"
}
formattributes24 = {
  :forms_id => 2,
  :column_name => "Move Out",
  :column_type => "Date"
}

formattributes21categorical1 = {
  :formattributes_id => '6',
  :option => '0',
  :name => 'minlength'
}

formattributes21categorical2 = {
  :formattributes_id => '6',
  :option => '100',
  :name => 'maxlength'
}

formattributes21categorical3 = {
  :formattributes_id => '7',
  :option => '0',
  :name => 'minlength'
}

formattributes21categorical4 = {
  :formattributes_id => '7',
  :option => '100',
  :name => 'maxlength'
}

formattributes21categorical5 = {
  :formattributes_id => '8',
  :option => '2017-01-01',
  :name => 'mindate'
}

formattributes21categorical6 = {
  :formattributes_id => '8',
  :option => '2018-01-01',
  :name => 'maxdate'
}

formattributes21categorical7 = {
  :formattributes_id => '9',
  :option => '2017-01-01',
  :name => 'mindate'
}

formattributes21categorical8 = {
  :formattributes_id => '9',
  :option => '2018-01-01',
  :name => 'maxdate'
}

project2 = {
  :project_name => "Mote Data",
  :research_group => "Epidimiology",
  :researchers_id => 1
}

form3 = {
  :form_name => "Mote Data Patient ICU Form",
  :projects_id => 2
}

formattributes31 = {
  :forms_id => 3,
  :column_name => "Name",
  :column_type => "String"
}
formattributes32 = {
  :forms_id => 3,
  :column_name => "Bed Number",
  :column_type => "Integer"
}
formattributes33 = {
  :forms_id => 3,
  :column_name => "Number of Day Stay",
  :column_type => "Integer"
}

formattributes31categorical1 = {
  :formattributes_id => '10',
  :option => '10',
  :name => 'length'
}

formattributes31categorical2 = {
  :formattributes_id => '11',
  :option => '0',
  :name => 'minlength'
}

formattributes31categorical3 = {
  :formattributes_id => '11',
  :option => '100',
  :name => 'maxlength'
}

formattributes31categorical4 = {
  :formattributes_id => '12',
  :option => '0',
  :name => 'minlength'
}

formattributes31categorical5 = {
  :formattributes_id => '12',
  :option => '100',
  :name => 'maxlength'
}

formaccess1 = {
  :forms_id => 1,
  :dataentries_id => 1
}

formaccess2 = {
  :forms_id => 2,
  :dataentries_id => 2
}

formaccess3 = {
  :forms_id => 3,
  :dataentries_id => 1
}

result1 = {
  :forms_id => 1,
  :jsondata => {"Name": "nabeel", "formID": "1", "Admit Date": "2018-11-16", "Room Number": "457", "Discharge Date": "2017-11-16", "Length of Stay": "19"}
}

result2 = {
  :forms_id => 1,
  :jsondata => {"Name": "vivek", "formID": "1", "Admit Date": "2018-03-21", "Room Number": "457", "Discharge Date": "2018-03-28", "Length of Stay": "7"}
}
result3 = {
  :forms_id => 1,
  :jsondata => {"Name": "indranil", "formID": "1", "Admit Date": "2018-04-08", "Room Number": "468", "Discharge Date": "2018-04-22", "Length of Stay": "14"}
}
result4 = {
  :forms_id => 1,
  :jsondata => {"Name": "abhijeet", "formID": "1", "Admit Date": "2018-01-27", "Room Number": "483", "Discharge Date": "2018-02-06", "Length of Stay": "10"}
}
result5 = {
  :forms_id => 1,
  :jsondata => {"Name": "rae", "formID": "1", "Admit Date": "2018-06-25", "Room Number": "638", "Discharge Date": "2018-07-25", "Length of Stay": "31"}
}
result6 = {
  :forms_id => 1,
  :jsondata => {"Name": "nicole", "formID": "1", "Admit Date": "2018-03-05", "Room Number": "187", "Discharge Date": "2018-03-09", "Length of Stay": "4"}
}
result7 = {
  :forms_id => 1,
  :jsondata => {"Name": "hammad", "formID": "1", "Admit Date": "2018-05-16", "Room Number": "564", "Discharge Date": "2018-06-29", "Length of Stay": "38"}
}
result8 = {
  :forms_id => 1,
  :jsondata => {"Name": "salman", "formID": "1", "Admit Date": "2018-09-09", "Room Number": "375", "Discharge Date": "2018-09-18", "Length of Stay": "9"}
}
result9 = {
  :forms_id => 1,
  :jsondata => {"Name": "hamza", "formID": "1", "Admit Date": "2018-04-11", "Room Number": "739", "Discharge Date": "2018-04-24", "Length of Stay": "13"}
}
result10 = {
  :forms_id => 1,
  :jsondata => {"Name": "olivia", "formID": "1", "Admit Date": "2018-02-06", "Room Number": "459", "Discharge Date": "2018-02-23", "Length of Stay": "17"}
}
result11 = {
  :forms_id => 1,
  :jsondata => {"Name": "amea", "formID": "1", "Admit Date": "2018-01-19", "Room Number": "34", "Discharge Date": "2018-02-08", "Length of Stay": "18"}
}
result12 = {
  :forms_id => 1,
  :jsondata => {"Name": "mia", "formID": "1", "Admit Date": "2018-08-16", "Room Number": "543", "Discharge Date": "2018-08-28", "Length of Stay": "12"}
}
result13 = {
  :forms_id => 1,
  :jsondata => {"Name": "lily", "formID": "1", "Admit Date": "2018-05-14", "Room Number": "120", "Discharge Date": "2018-05-27", "Length of Stay": "13"}
}
result14 = {
  :forms_id => 1,
  :jsondata => {"Name": "lily", "formID": "1", "Admit Date": "2018-04-19", "Room Number": "983", "Discharge Date": "2018-05-04", "Length of Stay": "15"}
}
result15 = {
  :forms_id => 1,
  :jsondata => {"Name": "sophia", "formID": "1", "Admit Date": "2018-03-15", "Room Number": "786", "Discharge Date": "2018-04-01", "Length of Stay": "16"}
}
result16 = {
  :forms_id => 1,
  :jsondata => {"Name": "grace", "formID": "1", "Admit Date": "2018-08-03", "Room Number": "10", "Discharge Date": "2018-08-17", "Length of Stay": "14"}
}
result17 = {
  :forms_id => 1,
  :jsondata => {"Name": "fred", "formID": "1", "Admit Date": "2018-11-16", "Room Number": "276", "Discharge Date": "2018-11-21", "Length of Stay": "5"}
}
result18 = {
  :forms_id => 1,
  :jsondata => {"Name": "nabhith", "formID": "1", "Admit Date": "2017-08-01", "Room Number": "671", "Discharge Date": "2018-08-18", "Length of Stay": "17"}
}
result19 = {
  :forms_id => 1,
  :jsondata => {"Name": "nabil", "formID": "1", "Admit Date": "2017-09-19", "Room Number": "107", "Discharge Date": "2017-10-17", "Length of Stay": "28"}
}
result20 = {
  :forms_id => 1,
  :jsondata => {"Name": "nabor", "formID": "1", "Admit Date": "2017-05-13", "Room Number": "89", "Discharge Date": "2017-06-04", "Length of Stay": "21"}
}
result21 = {
  :forms_id => 1,
  :jsondata => {"Name": "nabeh", "formID": "1", "Admit Date": "2017-11-13", "Room Number": "143", "Discharge Date": "2017-11-16", "Length of Stay": "3"}
}
result22 = {
  :forms_id => 1,
  :jsondata => {"Name": "naba", "formID": "1", "Admit Date": "2017-01-09", "Room Number": "36", "Discharge Date": "2017-01-06", "Length of Stay": "5"}
}

resultstaging1 = {
  :forms_id => 1,
  :updateneeded => false,
  :jsondata => {"Name": "Nabeel", "formID": "1", "Admit Date": "2018-11-16", "Room Number": "111", "Discharge Date": "2018-11-16", "Length of Stay": "10"}
}

resultstaging2 = {
  :forms_id => 1,
  :updateneeded => false,
  :jsondata => {"Name": "Vivek", "formID": "1", "Admit Date": "2018-11-16", "Room Number": "20", "Discharge Date": "2018-11-16", "Length of Stay": "20"}
}

resultstaging3 = {
  :forms_id => 1,
  :updateneeded => false,
  :jsondata => {"Name": "Rae", "formID": "1", "Admit Date": "2018-11-16", "Room Number": "30", "Discharge Date": "2018-11-16", "Length of Stay": "30"}
}

resultstaging4 = {
  :forms_id => 1,
  :updateneeded => false,
  :jsondata => {"Name": "Nicole", "formID": "1", "Admit Date": "2018-11-16", "Room Number": "40", "Discharge Date": "2018-11-16", "Length of Stay": "40"}
}

resultstaging5 = {
  :forms_id => 2,
  :updateneeded => false,
  :jsondata => {"Name": "Bob", "formID": "1", "Admit Date": "2018-11-16", "Room Number": "50", "Discharge Date": "2018-11-16", "Length of Stay": "50"}
}

resultstaging6 = {
  :forms_id => 2,
  :updateneeded => false,
  :jsondata => {"Name": "Ned", "formID": "1", "Admit Date": "2018-11-16", "Room Number": "60", "Discharge Date": "2018-11-16", "Length of Stay": "60"}
}

Authentication.create(researchauth1)
Authentication.create(researchauth2)
Authentication.create(dataentryauth1)
Authentication.create(dataentryauth2)

Researcher.create(researchUser1)
Researcher.create(researchUser2)

Dataentry.create(dataentryUser1)
Dataentry.create(dataentryUser2)

Project.create(project1)
Project.create(project2)

Form.create(form1)
Formattribute.create(formattributes11)
Formattribute.create(formattributes12)
Formattribute.create(formattributes13)
Formattribute.create(formattributes14)
Formattribute.create(formattributes15)
Categoricalformattribute.create(formattributes11categorical1)
Categoricalformattribute.create(formattributes11categorical2)
Categoricalformattribute.create(formattributes11categorical3)
Categoricalformattribute.create(formattributes11categorical4)
Categoricalformattribute.create(formattributes11categorical5)
Categoricalformattribute.create(formattributes11categorical6)
Categoricalformattribute.create(formattributes11categorical7)
Categoricalformattribute.create(formattributes11categorical8)
Categoricalformattribute.create(formattributes11categorical9)

Form.create(form2)
Formattribute.create(formattributes21)
Formattribute.create(formattributes22)
Formattribute.create(formattributes23)
Formattribute.create(formattributes24)
Categoricalformattribute.create(formattributes21categorical1)
Categoricalformattribute.create(formattributes21categorical2)
Categoricalformattribute.create(formattributes21categorical3)
Categoricalformattribute.create(formattributes21categorical4)
Categoricalformattribute.create(formattributes21categorical5)
Categoricalformattribute.create(formattributes21categorical6)
Categoricalformattribute.create(formattributes21categorical7)
Categoricalformattribute.create(formattributes21categorical8)

Form.create(form3)
Formattribute.create(formattributes31)
Formattribute.create(formattributes32)
Formattribute.create(formattributes33)
Categoricalformattribute.create(formattributes31categorical1)
Categoricalformattribute.create(formattributes31categorical2)
Categoricalformattribute.create(formattributes31categorical3)
Categoricalformattribute.create(formattributes31categorical4)
Categoricalformattribute.create(formattributes31categorical5)

Formsaccess.create(formaccess1)
Formsaccess.create(formaccess2)
Formsaccess.create(formaccess3)

Result.create(result1)
Result.create(result2)
Result.create(result3)
Result.create(result4)
Result.create(result5)
Result.create(result6)
Result.create(result7)
Result.create(result8)
Result.create(result9)
Result.create(result10)
Result.create(result11)
Result.create(result12)
Result.create(result13)
Result.create(result14)
Result.create(result15)
Result.create(result16)
Result.create(result17)
Result.create(result18)
Result.create(result19)
Result.create(result20)
Result.create(result21)
Result.create(result22)

Resultsstaging.create(resultstaging1)
Resultsstaging.create(resultstaging2)
Resultsstaging.create(resultstaging3)
Resultsstaging.create(resultstaging4)
Resultsstaging.create(resultstaging5)
Resultsstaging.create(resultstaging6)
