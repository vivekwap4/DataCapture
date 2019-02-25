Feature: Accessing and Interacting with the Forms Home Page

  Scenario: Getting to the Forms Home Page
    Given I am on the researcher login page
    And I enter a researcher with email "nabeelahmadkh@gmail.com" and password "qwerty1234"
    When I click on a project named "CDiff"
    Then I should be redirected to the project page and see the forms table
    When I click on a form named "CDiff Patient Form"
    Then I should be redirected to the form home page

    When I click the view and download charts link
    Then I should be redirected to the charts page
