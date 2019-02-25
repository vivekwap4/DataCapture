When /^I click on a form named "(.*?)"$/ do |form|
  click_link form
end

Then /^I should be redirected to the form home page$/ do
  expect(page).to have_content('CDiff Patient Form Data')
  expect(page).to have_content('Reset Search')
end

When /^I click the view and download charts link$/ do
  click_link 'View/Download Data Charts'
end

Then /^I should be redirected to the charts page$/ do
  expect(page).to have_content('Categorical Charts')
end
