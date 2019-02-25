Given /^I have logged in as a researcher with email "(.*?)" and password "(.*?)"$/ do |email, password|
  visit login_path
  fill_in 'inputEmailResearcher_researcher_email', with: email
  fill_in 'inputPasswordResearcher_researcher_password', with: password
  click_button 'researcher_submit'
end

When /^I click the create project link$/ do
  # expect(page).to have_content('Researcher Landing Page')
  # click_link 'create_project'
  find("a[href='/projects/new']").click
end

Then /^I should see all project creation page$/ do
  expect(page).to have_content('Create Project')
end

When /^I create a project with name "(.*?)" and research group "(.*?)"$/ do |name, group|
  fill_in 'inputName', with: name
  fill_in 'inputResearchGroup', with: group
  click_button 'create_project_submit'
end

Then /^I should be redirected to the landing page  and see the appropriate flash message$/ do
  # expect(page).to have_content('Researcher Landing Page')
  expect(page).to have_content('Create Project')
end
