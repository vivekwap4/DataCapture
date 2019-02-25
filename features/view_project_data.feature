Feature: Functional View Project Data

  Scenario: View Project Data
    Given I am on the researcher login page then
    When I enter a  researcher with email "nabeelahmadkh@gmail.com" and password "qwerty1234"
    Then I should  be redirected to the researcher landing page
    When I click  on project with the link "/projects/1"
    Then I should see the details about the project


  Scenario: Create Form
    Given I am on the researcher login page then
    When I enter a  researcher with email "nabeelahmadkh@gmail.com" and password "qwerty1234"
    Then I should  be redirected to the researcher landing page
    When I click  on project with the link "/projects/1"
    Then I should see the details about the project
    When I click on the Add form link
    Then I should see pop up to select the project
