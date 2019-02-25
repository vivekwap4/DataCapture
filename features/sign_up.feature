Feature: Functional Sign Up

  Scenario: Create a new researcher
    Given I am on the login page
    And I click the create account page
    When I enter a user with first name "John", last name "Doe", email "j-doe@gmail.com", research group "Group", password "test", and confirmation password "test"
    Then I should be redirected to the homepage and see a positive flash message

  Scenario: Create a new data entry person
    Given I am on the data entry sign up page
    When I enter a user with first name "John", last name "Doe", email "j-doe@gmail.com", profile "NA", institution "UofI", password "test", and confirmation password "test"
    Then I should be redirected to the homepage and see a positive flash message
