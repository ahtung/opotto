@javascript, @omniauth_test
Feature: Me Page
  In order to have insight on usage
  A User
  Should be able to view stats

  Scenario: Me
    Given I am a new, authenticated user
    When I visit Me Page
    Then page should have "Stats"
     And page should have "Contributed To"
     And page should have "Created"
     And page should have "Invited"
     And I should see user's contributed jars
     And I should see user's created jars
     And I should see user's invited jars
