Given /^I am on the login page$/ do
  visit login_path
end

And /^I click the create account page$/ do
  click_link 'create_account_link'
end

When /^I enter a user with first name "(.*?)", last name "(.*?)", email "(.*?)", research group "(.*?)", password "(.*?)", and confirmation password "(.*?)"$/ do |first, last, email, group, password, confirm_password|
  fill_in 'First Name', with: first
  fill_in 'Last Name', with: last
  fill_in 'Email', with: email
  fill_in 'Research Group', with: group
  fill_in 'Password', with: password
  fill_in 'Confirm Password', with: confirm_password
  click_button 'Submit'
end

Then /^I should be redirected to the homepage and see a positive flash message$/ do
  expect(page).to have_content('User is Successfully Created')
end

Given /^I am on the data entry sign up page$/ do
  visit dataentry_signup_path
end

When /^I enter a user with first name "(.*?)", last name "(.*?)", email "(.*?)", profile "(.*?)", institution "(.*?)", password "(.*?)", and confirmation password "(.*?)"$/ do |first, last, email, profile, institution, password, confirm_password|
  fill_in 'First Name', with: first
  fill_in 'Last Name', with: last
  fill_in 'Email', with: email
  fill_in 'Profile', with: profile
  fill_in 'Institution', with: institution
  fill_in 'Password', with: password
  fill_in 'Confirm Password', with: confirm_password
  click_button 'Submit'
end
