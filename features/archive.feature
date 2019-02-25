Feature: Create Project

  Background: user is present on the landing page
    Given I am on the login page
    When I enter a researcher with email "nabeelahmadkh@gmail.com" and password "qwerty1234"
    Then I should be redirected to the researcher landing page

  Scenario: Go to Archive Page
    Given I am on the researcher landing page
    When I click on the Archive Link
    Then I should see archived forms
