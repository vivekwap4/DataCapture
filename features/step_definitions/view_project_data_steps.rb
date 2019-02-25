Given /^I am on the researcher login page then$/ do
  visit login_path
end

When /^I enter a  researcher with email "(.*?)" and password "(.*?)"$/ do |email, password|
  fill_in 'inputEmailResearcher_researcher_email', with: email
  fill_in 'inputPasswordResearcher_researcher_password', with: password
  click_button 'researcher_submit'
end

Then /^I should  be redirected to the researcher landing page$/ do
  expect(page).to have_content('Researcher Landing Page')
end

When /^I click  on project with the link "(.*?)"$/ do |link|
  find("a[href='#{link}']").click
end

Then /^I should see the details about the project$/ do
  expect(page).to have_content('CDiff Home Page')
end

When /^I click on the Add form link$/ do
  find("a[href='/researcher/generateform']").click
end

Then /^I should see pop up to select the project$/ do
  expect(page).to have_content('Select Project')
end
