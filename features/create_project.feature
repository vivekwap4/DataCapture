Feature: Create Project

  Scenario: Creating a New Project
    Given I am on the researcher login page
    And I enter a researcher with email "nabeelahmadkh@gmail.com" and password "qwerty1234"
    When I click the create project link
    Then I should see all project creation page
    When I create a project with name "Test Project 65" and research group "Test Group"
    Then I should be redirected to the landing page  and see the appropriate flash message
