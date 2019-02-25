#Before running Cucumber, be sure to run the following command to prepare the test environment: rake db:test:prepare

Given /^I am on the Data Capture homepage$/ do
  visit '/'
end

#Given /^I have logged in as a researcher with email "(.*?)" and password "(.*?)"$/ do |email, password|
#  visit '/'
#  click_link 'login_link'
#  fill_in 'inputEmailResearcher_researcher_email', with: email
#  fill_in 'inputPasswordResearcher_researcher_password', with: password
#  click_button 'researcher_submit'
#  expect(page).to have_content('Researcher Landing Page')
#end

When /^I click the link for the tutorials page$/ do
  click_link 'tutorials_link'
end
Then /^The link should take me to the tutorials page$/ do
  expect(page).to have_content('Tutorial Page')
end
When /^I click the login link$/ do
  click_link 'login_link'
end
Then /^I should be redirected to the login, sign up page$/ do
  expect(page).to have_content('Login')
end

Given /^I am on the researcher landing page$/ do
  visit '/'
end
And /^I click the My Projects link$/ do
  click_link 'my_projects_link'
end
Then /^I should be redirected to the landing page$/ do
  expect(page).to have_content('Researcher Landing Page')
end
And /^I click the profile link$/ do
  click_link 'profile_link'
end
Then /^I should be redirected to the profile page$/ do
  expect(page).to have_content('Profile')
end
And /^I click the Grant Access link$/ do
  click_link 'grant_access_link'
end
Then /^I should be redirected to the grant access page$/ do
  expect(page).to have_content('Select Project')
end
And /^I click the Approve Data link$/ do
  click_link 'approve_data_link'
end
Then /^I should be redirected to the approve data page$/ do
  expect(page).to have_content('Select Project')
end
And /^I click the Archive link$/ do
  click_link 'archive_link'
end
Then /^I should be redirected to the Archives page$/ do
  expect(page).to have_content('Archived Forms')
end

Then /^I should see the projects table header$/ do
  expect(page).to have_content('Projects')
end
Then /^I should see the Project Name column$/ do
  expect(page).to have_content('Project Name')
end
Then /^I should see the Project ID column$/ do
  expect(page).to have_content('Project ID')
end
Then /^I should see the Number of Forms column$/ do
  expect(page).to have_content('Number of Forms')
end
Then /^I should see the Recent Activity column$/ do
  expect(page).to have_content('Recent Activity')
end
Then /^I should see the Project Creation Timeline chart title$/ do
  expect(page).to have_content('Project Creation Timeline')
end
