Given /^I am on the researcher login page$/ do
  visit login_path
end

When /^I enter a researcher with email "(.*?)" and password "(.*?)"$/ do |email, password|
  fill_in 'inputEmailResearcher_researcher_email', with: email
  fill_in 'inputPasswordResearcher_researcher_password', with: password
  click_button 'researcher_submit'
end

Then /^I should be redirected to the researcher landing page$/ do
 expect(page).to have_content('Researcher Landing Page')
end

Then /^I should be redirected to the sign up page and see the appropriate flash message$/ do
  expect(page).to have_content('User does not exist')
end

Given /^I am on the data entry login page$/ do
  visit login_path
  click_link 'data_entry_login_link'
end

When /^I enter a data entry user with email "(.*?)" and password "(.*?)"$/ do |email, password|
  fill_in 'inputEmailDataEntry_data_entry_email', with: email
  fill_in 'inputPasswordDataEntry_data_entry_password', with: password
  click_button 'data_entry_submit'
end

Then /^I should be redirected to the data entry landing page$/ do
  expect(page).to have_content('Data Entry Landing Page')
end
