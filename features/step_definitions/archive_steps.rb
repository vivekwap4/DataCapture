When /^I click on the Archive Link$/ do
  find("a[href='/researcher/archive']").click
end

Then /^I should see archived forms$/ do
  expect(page).to have_content('Archived Forms')
end
