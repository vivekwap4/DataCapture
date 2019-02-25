Feature: Functional Login

  Scenario: Researcher Login
    Given I am on the researcher login page
    When I enter a researcher with email "nabeelahmadkh@gmail.com" and password "qwerty1234"
    Then I should be redirected to the researcher landing page

  Scenario: Data Entry Person Login
    Given I am on the data entry login page
    When I enter a data entry user with email "rae@gmail.com" and password "qwerty1234"
    Then I should be redirected to the data entry landing page

  Scenario: Unsuccessful Login
    Given I am on the researcher login page
    When I enter a researcher with email "not@gmail.com" and password "not"
    Then I should be redirected to the sign up page and see the appropriate flash message
