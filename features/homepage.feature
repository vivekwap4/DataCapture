Feature: Functional Homepage

  Scenario: Check tutorial link exists
    Given I am on the Data Capture homepage
    When I click the link for the tutorials page
    Then The link should take me to the tutorials page

  Scenario: Check that login link exists
    Given I am on the Data Capture homepage
    When I click the login link
    Then I should be redirected to the login, sign up page

  Scenario: Check that side bar links function
    Given I have logged in as a researcher with email "nabeelahmadkh@gmail.com" and password "qwerty1234"
    And I click the My Projects link
    Then I should be redirected to the landing page

    Given I am on the Data Capture homepage
    And I click the profile link
    Then I should be redirected to the profile page

    Given I am on the researcher landing page
    And I click the Grant Access link
    Then I should be redirected to the grant access page

    Given I am on the researcher landing page
    And I click the Approve Data link
    Then I should be redirected to the approve data page

    Given I am on the researcher landing page
    And I click the Archive link
    Then I should be redirected to the Archives page

    Given I am on the researcher landing page
    Then I should see the projects table header

    Given I am on the researcher landing page
    Then I should see the Project Name column

    Given I am on the researcher landing page
    Then I should see the Project ID column

    Given I am on the researcher landing page
    Then I should see the Number of Forms column

    Given I am on the researcher landing page
    Then I should see the Recent Activity column

    Given I am on the researcher landing page
    Then I should see the Project Creation Timeline chart title


