When /^I click on a project named "(.*?)"$/ do |project|
  click_link project
end

Then /^I should be redirected to the project page and see the forms table$/ do
  expect(page).to have_content('Forms')
  expect(page).to have_content('Tasks')
end

Then /^I should be redirected to the project page and see forms charts$/ do
  expect(page).to have_content('Form Creation Timeline')
  expect(page).to have_content('Records Added')
end
