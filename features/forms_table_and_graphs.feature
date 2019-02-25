Feature: Project Home Page Has Forms Table and Places for Graphs

  Scenario: Finding forms table on project home page
    Given I am on the researcher login page
    And I enter a researcher with email "nabeelahmadkh@gmail.com" and password "qwerty1234"
    When I click on a project named "CDiff"
    Then I should be redirected to the project page and see the forms table

  Scenario: Finding forms graphs
    Given I am on the researcher login page
    And I enter a researcher with email "nabeelahmadkh@gmail.com" and password "qwerty1234"
    When I click on a project named "CDiff"
    Then I should be redirected to the project page and see forms charts
