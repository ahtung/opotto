@javascript @omniauth_test @ignore
Feature: Me Page
  In order to have insight on usage
  A User
  Should be able to view stats

  Scenario: Me
    When I sign in with "dunyakirkali@gmail.com"
     And I visit Me Page
    Then page should have "Stats"
     And page should have "Contributed To"
     And page should have "Created"
     And page should have "Invited"
     And I should see user's contributed jars
     And I should see user's created jars
     And I should see user's invited jars
